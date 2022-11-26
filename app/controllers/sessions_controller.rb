class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(profile: params[:session][:profile])
    # 入力されたURLを持つユーザーがデータベースに存在し、
    # かつ入力されたパスワードがそのユーザーのパスワードであるかチェック
    if @user&.authenticate(params[:session][:password])
      # セッション情報がリセットされる前にURLを保存する
      forwarding_url = session[:forwarding_url]
      reset_session
      # remember_me の値が１の場合 remember(@user) を実行
      # 0の場合、forget(@user) を実行
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      redirect_to forwarding_url || @user
    else
      flash.now[:danger] = 'パスワードかプロフィールURLが正しくありません'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    # :destroyアクションを保護するのに使われるので、
    # status: :see_otherを記述している
    redirect_to root_url, status: :see_other
  end
end
