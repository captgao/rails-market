class Shoppinglist < ApplicationRecord
     belongs_to :user
     has_many :items
     def total_price (l)
	res = 0
         l.items.collect do |item|
		begin
		p = Product.find(item.product_id)
		res = res + p.price * item.quantity
		rescue ActiveRecord::RecordNotFound
		2.33
		end

	end
        res = res
     end
     def all_items (l)
	str = String.new
	name_list = Array.new
	l.items.collect do |item|
		begin
		p = Product.find(item.product_id)
		name_list.push(p.p_name)
		rescue ActiveRecord::RecordNotFound
		2.33
		end
	end
	name_list.join(",")
     end
end
