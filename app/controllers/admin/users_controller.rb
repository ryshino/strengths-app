class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :logged_in_user
  before_action :set_q, only: [:index]

  def index
    @users = @q.result.paginate(page: params[:page])
    if @users.blank?
      flash.now[:success] = "該当のユーザーは見つかりませんでした。"
    end
  end

  private

    def set_q
      @q = User.ransack(params[:q])
    end

    # 管理者かどうか確認
    def admin_user
      unless logged_in? && current_user.admin?
        redirect_to(root_url, status: :see_other)
        flash[:danger] = "管理者のみアクセスできます"
      end
    end
end
