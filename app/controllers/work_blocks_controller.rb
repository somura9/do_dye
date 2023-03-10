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

      @work_block.creaet_blockable!(blockable_type, params)
    end

    redirect_to @work
  end

  def edit
    if @work_block.sentence?
      set_sentence
    elsif @work_block.medium?
      set_medium
    elsif @work_block.embed?
      set_embed
    end
  end

  def update
    WorkBlock.transaction do
      if @work_block.sentence?
        set_sentence
        @sentence.update!(sentence_params)
      elsif @work_block.medium?
        set_medium
        @medium.update!(medium_params)
      elsif @work_block.embed?
        set_embed
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

  def set_work
    @work = Work.find_by!(id: params[:work_id])
  end

  def set_work_block
    @work_block = @work.work_blocks.find(params[:id])
  end

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

  def set_sentence
    @sentence = Sentence.find(@work_block.blockable_id)
  end

  def set_medium
    @medium = Medium.find(@work_block.blockable_id)
  end

  def set_embed
    @embed = Embed.find(@work_block.blockable_id)
  end
end
