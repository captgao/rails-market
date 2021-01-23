class CreateShoppinglists < ActiveRecord::Migration[5.2]
  def change
    create_table :shoppinglists do |t|
      t.integer :manipulator_type
      t.float :total
      t.time :time

      t.timestamps
    end
  end
end
