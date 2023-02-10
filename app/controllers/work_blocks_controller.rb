class WorkBlocksController < ApplicationController
  before_action :set_work
  before_action :set_work_block, only: %i[show edit update destroy]

  def show; end

  def new
    @blockable_type = params[:blockable_type]
    @work_block = WorkBlock.new
    @tab = params[:tab]
  end

  def create
    WorkBlock.transaction do
      @work_block = @work.work_blocks.new(tab_id: params[:tab])
      blockable_type = params[:blockable_type]

      return head :bad_request if blockable_type.blank? || !WorkBlock.valid_blockable_type?(blockable_type)

      case blockable_type
      when 'Sentence'
        @work_block.blockable = Sentence.create!(body: params[:body])
      when 'Medium'
        @work_block.blockable = Medium.create!(name: params[:name])
      when 'Embed'
        @work_block.blockable = Embed.create!(identifier: params[:identifier])
      end

      @work_block.save!
    end

    redirect_to @work
  end

  def edit
    if @work_block.sentence?
      @sentence = Sentence.find(@work_block.blockable_id)
    elsif @work_block.medium?
      @medium = Medium.find(@work_block.blockable_id)
    elsif @work_block.embed?
      @embed = Embed.find(@work_block.blockable_id)
    end
  end

  def update
    WorkBlock.transaction do
      if @work_block.sentence?
        @sentence = Sentence.find(@work_block.blockable_id)
        @sentence.update!(sentence_params)
      elsif @work_block.medium?
        @medium = Medium.find(@work_block.blockable_id)
        @medium.update!(medium_params)
      elsif @work_block.embed?
        @embed = Embed.find(@work_block.blockable_id)
        @embed.update!(embed_params)
      end
    end

    redirect_to @work
  end

  def destroy
    @work_block.destroy!
    redirect_to @work
  end

  private

  def work_block_params
    params.require(:work_block).permit(:tab_id)
  end

  def sentence_params
    params.require(:sentence).permit(:body)
  end

  def medium_params
    params.require(:medium).permit(:name)
  end

  def embed_params
    params.require(:embed).permit(:embed_type, :identifier)
  end

  def set_work
    @work = Work.find_by!(id: params[:work_id])
  end

  def set_work_block
    @work_block = @work.work_blocks.find(params[:id])
  end
end
