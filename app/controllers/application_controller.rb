class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        # store_locationによってリクエストされたURLを保存しておく
        store_location
        flash[:danger] = "ログインが必要です"
        redirect_to login_url, status: :see_other
      end
    end
end
