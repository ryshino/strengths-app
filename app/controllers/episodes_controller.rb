class EpisodesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy, :show]
  before_action :correct_user,   only: :destroy
  before_action :set_q, only: [:index]

  def index
    @episodes = @q.result.paginate(page: params[:page])
    @episode  = current_user.episodes.build
    if @episodes.blank?
      flash.now[:success] = "該当のエピソードは見つかりませんでした。"
    end
  end

  def new
    @episode = Episode.new
  end

  def create
    @episode = current_user.episodes.build(episode_params)
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
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @episode = Episode.find(params[:id])
    @tag_relation = current_user.tag_relations.find_or_initialize_by(episode_id: @episode.id)
    @current_user_select_tags = current_user.tag_relations.where(episode_id: @episode.id).pluck(:tag_id)
    search_select_tags = Episode.joins(tag_relations: :tag).group(:episode_id, :name).
                  having("CAST(episode_id as INTEGER) = ?", @episode.id).size
    @episode_tags = search_select_tags.map { |k, v| [k.slice(1), v] }
  end

  def destroy
    @episode.destroy
    flash[:success] = "投稿を削除しました"
    # 直前のページにリダイレクトしなければ指定したページ(root_url)へリダイレクト
    redirect_back_or_to(root_url, status: :see_other)
  end

  private

    def set_q
      @q = Episode.ransack(params[:q])
    end

    def episode_params
      params.require(:episode).permit(:title, :content)
    end

    def tag_params
      params.require(:episode).permit(tag_ids: [])
    end

    def correct_user
      @episode = current_user.episodes.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @episode.nil?
    end
end
