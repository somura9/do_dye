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
    @user = User.find(params[:id])
    @works = Work.where(user_id: params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to @user
    else
      flash.now[:danger]
      render :new
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @user.destroy! 
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name ,:email, :password, :password_confirmation, :bio)
  end
end
