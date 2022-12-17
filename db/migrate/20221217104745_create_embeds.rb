class CreateEmbeds < ActiveRecord::Migration[7.0]
  def change
    create_table :embeds do |t|
      t.string :embed_type
      t.string :identifier
      t.references :tab, null: false, foreign_key: true

      t.timestamps
    end
  end
end
