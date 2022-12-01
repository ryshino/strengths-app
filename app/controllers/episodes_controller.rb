class EpisodesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @episode = current_user.episodes.build(episode_params)
    if @episode.save
      flash[:success] = "エピソードを投稿しました"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

    def episode_params
      params.require(:episode).permit(:content)
    end
end
