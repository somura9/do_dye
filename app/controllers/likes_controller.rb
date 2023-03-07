class LikesController < ApplicationController
  before_action :require_login

    def create
      @work = Work.find(params[:work_id])
      current_user.like(@work)
      redirect_back fallback_location: root_path
    end

    def destroy
      @work = current_user.likes.find(params[:id]).work
      current_user.unlike(@work)
      redirect_back fallback_location: root_path
    end
end
