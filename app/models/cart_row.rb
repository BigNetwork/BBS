class CartRow < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_type
  
  validates_numericality_of :quantity
end
