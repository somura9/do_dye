class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.string :name
      t.references :tab, null: false, foreign_key: true

      t.timestamps
    end
  end
end
