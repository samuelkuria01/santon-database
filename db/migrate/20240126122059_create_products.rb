class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      t.string :image
      t.string :information

      t.timestamps
    end
  end
end
