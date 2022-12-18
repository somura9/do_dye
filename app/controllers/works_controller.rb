class WorksController < ApplicationController
  def new
    @work = Work.new
  end

  def create
    user = User.find(1)
    @work = user.works.build(work_params)
    if @work.valid?
      @work.save
      redirect_to root_path
    else
      flash.now[:danger]
      render :new
    end

  end

  def index
  end

  def show
  end

  def edit
  end
  private
  def work_params
    params.require(:work).permit(:title, :summary)
  end
end
