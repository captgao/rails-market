class AddUserRefToShoppinglists < ActiveRecord::Migration[5.2]
  def change
    add_reference :shoppinglists, :user, foreign_key: true
  end
end
