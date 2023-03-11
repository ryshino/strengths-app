class EpisodesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :set_q, only: [:index]

  def index
    @episodes = @q.result.page(params[:page]).per(12)
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
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @episode.update(episode_params)
      flash[:success] = "エピソードの内容を更新しました"
      redirect_to @episode
    else
      render 'edit', status: :unprocessable_entity
    end  
  end

  def show
    @episode = Episode.find(params[:id])
    @tag_relation = current_user.tag_relations.find_or_initialize_by(episode_id: @episode.id)
    @current_user_select_tags = current_user.tag_relations.where(episode_id: @episode.id).pluck(:tag_id)
    @episode_tags = @episode.tags.group(:name).count
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
