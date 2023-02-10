# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def authenticate_admin
      # admin以外のユーザーはroot_pathに飛ばす
      redirect_to root_path, warning: '権限がありません' unless current_user&.admin?
    end

    def not_authenticated
      flash[:warning] = 'ログインしてください'
      redirect_to admin_login_path
    end
  end
end
