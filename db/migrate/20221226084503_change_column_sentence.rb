class ChangeColumnSentence < ActiveRecord::Migration[7.0]
  def change
    add_reference :sentences, :work_block, foreign_key: true
    remove_column :sentences, :tab_id, :bigint
  end
end
