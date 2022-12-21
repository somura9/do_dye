class WorksController < ApplicationController
  before_action :set_current_user_work, only: %i[edit update destroy]
  skip_before_action :require_login, only: %i[new create show index]

  def new
    @work = Work.new
  end

  def create
    @work = current_user.works.build(work_params)
    if @work.valid?
      @work.save
      redirect_to @work
    else
      flash.now[:danger]
      render :new
    end
  end

  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
  end

  def edit
  end

  def update
    if @work.update(work_params)
      redirect_to @work
    else
      flash.now['danger']
      render :edit
    end
  end

  def destroy
    @work.destroy! 
    redirect_to root_path
  end

  private
  def set_current_user_work
    @work = current_user.works.find(params[:id])
  end

  def work_params
    params.require(:work).permit(:title, :summary)
  end
end