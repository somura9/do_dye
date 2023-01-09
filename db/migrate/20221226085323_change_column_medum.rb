class ChangeColumnMedum < ActiveRecord::Migration[7.0]
  def change
    add_reference :media, :work_block, foreign_key: true
    remove_column :media, :tab_id, :bigint
  end
end
