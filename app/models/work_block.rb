class WorkBlock < ApplicationRecord
  belongs_to :work
  belongs_to :blockable, polymorphic: true, dependent: :destroy
  belongs_to :tab

  class << self
    def blockable_types
      %w[Sentence Medium Embed]
    end

    def valid_blockable_type?(type)
      blockable_types.include?(type.to_s.classify)
    end
  end

  def sentence?
    blockable.is_a?(Sentence)
  end

  def medium?
    blockable.is_a?(Medium)
  end

  def embed?
    blockable.is_a?(Embed)
  end

  def creaet_blockable!(type, params)
    case type.to_s.classify
    when 'Sentence'
      set_work_work_block(params)
      @work_block.blockable = Sentence.create!(body: params[:body])
      @work_block.save!
    when 'Medium'
      @work = Work.find_by!(id: params[:work_id])
      params[:name].each do |name|
        @work_block = @work.work_blocks.new(tab_id: params[:tab])
        @work_block.blockable = Medium.create!(name: name)
        @work_block.save!
      end
    when 'Embed'
      set_work_work_block(params)
      @work_block.blockable = Embed.create!(identifier: params[:identifier])
      @work_block.save!
    end
    blockable
  end

  def set_work_work_block(params)
    @work = Work.find_by!(id: params[:work_id])
    @work_block = @work.work_blocks.new(tab_id: params[:tab])
  end
end
