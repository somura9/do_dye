class CreateWorkBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :work_blocks do |t|
      t.references :work, null: false, foreign_key: true
      t.references :blockable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
