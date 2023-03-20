class WorksController < ApplicationController
  before_action :set_current_user_work, only: %i[edit update destroy]
  skip_before_action :require_login, only: %i[new create show index]

  def new
    @work = Work.new
  end

  def create
    @work = current_user.works.build(work_params)
    tag_list = params[:work][:tag_name].split(',').uniq
    if @work.valid?
      @work.save
      @work.save_tag(tag_list)
      redirect_to @work
    else
      @tags = params[:work][:tag_name]
      flash.now[:danger]
      render :new
    end
  end

  def index
    @works = Work.publish.order(id: :DESC)
  end

  def show
    @work = Work.find(params[:id])
    @storys = @work.work_blocks.where(tab_id: 1).preload(:blockable)
    @characters = @work.work_blocks.where(tab_id: 2).preload(:blockable)
    @logs = @work.work_blocks.where(tab_id: 3).preload(:blockable).order(id: :DESC)
    @work_blocks = @work.work_blocks.preload(:blockable)
  end

  def edit
    @tags = @work.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:work][:tag_name].split(',').uniq
    if @work.update(work_params)
      @work.save_tag(tag_list)
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

  def likes
    @like_works = current_user.like_works.includes(:user).order(created_at: :desc)
  end

  private

  def set_current_user_work
    @work = current_user.works.find(params[:id])
  end

  def work_params
    params.require(:work).permit(:title, :summary, :thumbnail, :thumbnail_cache, :status)
  end
end
