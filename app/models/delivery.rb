class Delivery < ActiveRecord::Base
  has_many :products
  belongs_to :product_type
  
  validates_presence_of :product_type_id, :quantity
  validates_numericality_of :product_type_id, :quantity
end
