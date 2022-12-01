class EpisodesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @episode = current_user.episodes.build(episode_params)
    @episode.image.attach(params[:episode][:image])
    if @episode.save
      flash[:success] = "エピソードを投稿しました"
      redirect_to root_url
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

    def correct_user
      @episode = current_user.episodes.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @episode.nil?
    end
end
