class CartRow < ActiveRecord::Base
  belongs_to :cart
  has_one :product_type
end
