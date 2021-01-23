class Product < ApplicationRecord
	def addstock (i)
		a = self.quantity + i
		self.update(quantity :a)
        end
end
