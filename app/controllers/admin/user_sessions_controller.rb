module Admin
  class Admin::UserSessionsController < ApplicationController
    skip_before_action :authenticate_admin, only: %i[new create]
    layout 'application'

    def new; end

    def create
      @user = login(params[:email], params[:password]) # Sorceryメソッド。emailとpasswordでログイン認証する。
      if @user
        redirect_to admin_root_path, success: 'ログインしました'
      else
        flash.now[:danger] = 'ログインに失敗しました'
        render :new
      end
    end
  end
end
