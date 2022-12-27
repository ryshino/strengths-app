class EpisodesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @episodes = Episode.paginate(page: params[:page])
    @episode  = current_user.episodes.build

    # AND検索
    if params[:tag_ids]
      @episodes = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          # タグに紐づく投稿を代入
          tag_episodes = Tag.find_by(name: key).episodes
          # @episodesが空の場合、tag_articlesを代入
          # 空でない場合、@episodesとtag_episodesの値を代入する
          @episodes = @episodes.empty? ? tag_episodes : @episodes & tag_episodes
        end
      end
      if @episodes.empty?
        @episodes
      else
        @episodes = @episodes.paginate(page: params[:page])
      end
    end
  end

  def create
    @episode = current_user.episodes.build(episode_params)
    @episode.image.attach(params[:episode][:image])
    @tag_ids = params[:episode][:tag_ids]
    @tag_ids.each do |tag_id|
      @tag_relation = @episode.tag_relations.build(tag_id: tag_id, user_id: current_user.id)
    end
    @episode.tag_relations.first.delete
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
