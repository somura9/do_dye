class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_back_or_to root_path
    else
      flash.now[:danger]
      render :new
    end
  end

  def show
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(:name ,:email, :password, :password_confirmation)
  end
end
