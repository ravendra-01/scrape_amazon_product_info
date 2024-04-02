class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :contact_info
      t.string :size
      t.string :category
      t.string :url

      t.timestamps
    end
  end
end
