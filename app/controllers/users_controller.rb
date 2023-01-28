class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :set_q, only: [:index]

  def index
    @users = @q.result.paginate(page: params[:page])
    if @users.blank?
      flash.now[:success] = "該当のユーザーは見つかりませんでした。"
    end
  end

  def show
    @user = User.find(params[:id])
    @episodes = @user.episodes.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.profile_icon.attach(params[:user][:profile_icon]) if @user.profile_icon.attached?
    @user.strength_image.attach(params[:user][:strength_image]) if @user.strength_image.attached?
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "ユーザー登録に成功しました"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url, status: :see_other
  end

  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  private

    def set_q
      @q = User.ransack(params[:q])
    end

    def user_params
      # adminを含んでいないのは任意のユーザーが
      # 自分自身にアプリケーションの管理者権限を与えることを防止するため
      params.require(:user).permit(:name, :profile, :password,
                                  :password_confirmation, :profile_icon, :strength_image)
    end

    # beforeフィルタ

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
