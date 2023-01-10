class AddTabIdFromWorkBlocks < ActiveRecord::Migration[7.0]
  def change
    add_reference :work_blocks, :tab, foreign_key: true
  end
end
