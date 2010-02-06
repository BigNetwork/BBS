class Cart < ActiveRecord::Base
  has_many :cart_rows
  has_many :product_types, :through => :cart_rows
  has_one :purchase
end
