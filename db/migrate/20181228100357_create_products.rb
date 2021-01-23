class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :p_name
      t.text :description
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
