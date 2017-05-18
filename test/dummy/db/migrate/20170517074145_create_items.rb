class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :note
      t.decimal :price, default: 0
      t.string :image_url
      t.date :expired_at

      t.timestamps
    end
  end
end
