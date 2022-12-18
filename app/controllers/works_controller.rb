class WorksController < ApplicationController
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
    @work = Work.find(params[:id])
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to @work
    else
      flash.now['danger']
      render :edit
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy! 
    redirect_to root_path
  end

  private
  def work_params
    params.require(:work).permit(:title, :summary)
  end
end
