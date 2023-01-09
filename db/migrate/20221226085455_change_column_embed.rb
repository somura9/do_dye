class ChangeColumnEmbed < ActiveRecord::Migration[7.0]
  def change
    add_reference :embeds, :work_block, foreign_key: true
    remove_column :embeds, :tab_id, :bigint
  end
end
