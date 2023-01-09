class RemoveWorkIdFromTabs < ActiveRecord::Migration[7.0]
  def change
    remove_column :tabs, :work_id, :bigint
  end
end
