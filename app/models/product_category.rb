class ProductCategory < ActiveRecord::Base
  has_many :product_types
  
  default_scope :order => 'name'
end
