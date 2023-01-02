class EpisodesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy, :show]
  before_action :correct_user,   only: :destroy

  def index
    @episodes = Episode.paginate(page: params[:page])
    @episode  = current_user.episodes.build

    # AND検索
    if params[:tag_ids]
      @tag_episodes = []
      params[:tag_ids].select { |k, v| v == "1" }.each do |key, value|
        # タグに紐づく投稿を代入
        tags = Tag.find_by(name: key).episodes
        # @episodesが空の場合、tag_articlesを代入
        # 空でない場合、@episodesとtag_episodesの値を代入する
        @tag_episodes = @tag_episodes.empty? ? tags : @tag_episodes & tags
      end
      
      if @tag_episodes.empty?
        @episodes = @tag_episodes
      else
        # @tag_episodesはArrayクラスのため、paginateの部分でエラーになる
        # そのためwhereを使ってActiveRecord_Relationを
        # 継承させている
        @episodes = Episode
        @tag_episodes.each do |episode|
          @episodes = @episodes.where("id LIKE ?", episode.id)
        end
        @episodes = @episodes.paginate(page: params[:page])
      end
    end

    # if params[:tag_ids]
    #   # タグづけされているエピソードのみを抽出
    #   # debugger
    #   @episodes = TagRelation.joins(:episode, :tag).select("episodes.*, tags.*")
    #   params[:tag_ids].select { |k, v| v == "1" }.each do |key, value|
    #     @episodes = @episodes.where("name LIKE ?", "%#{key}")
    #   end

    #   if @episodes.empty?
    #     @episodes
    #   else
    #     @episodes = @episodes.paginate(page: params[:page])
    #   end
    # end
  end

  def show
    @episode = Episode.find(params[:id])
    @user = current_user
  end

  def create
    @episode = current_user.episodes.build(episode_params)
    @episode.image.attach(params[:episode][:image])
    @tag_ids = params[:episode][:tag_ids]
    # 空文字を除いてeach文を回している
    @tag_ids.reject { |id| id.blank? }.each do |tag_id|
      @tag_relation = @episode.tag_relations.build(tag_id: tag_id, user_id: current_user.id)
    end
    if @episode.save
      flash[:success] = "エピソードを投稿しました"
      redirect_to episodes_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @episode.destroy
    flash[:success] = "投稿を削除しました"
    # 直前のページにリダイレクトしなければ指定したページ(root_url)へリダイレクト
    redirect_back_or_to(root_url, status: :see_other)
  end

  private

    def episode_params
      params.require(:episode).permit(:content, :image)
    end

    def tag_params
      params.require(:episode).permit(tag_ids: [])
    end

    def correct_user
      @episode = current_user.episodes.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @episode.nil?
    end
end
