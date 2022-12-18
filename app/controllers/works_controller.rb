class WorksController < ApplicationController
  before_action :set_work, only: %i[show edit update destroy]
  def new
    @work = Work.new
  end

  def create
    user = User.find(1)
    @work = user.works.build(work_params)
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
  def set_work
    @work = Work.find(params[:id])
  end

  def work_params
    params.require(:work).permit(:title, :summary)
  end
end
