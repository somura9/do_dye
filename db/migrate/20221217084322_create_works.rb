class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.string :title, null: false
      t.string :thumbnail
      t.string :summary
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
