class Delivery < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  belongs_to :product_type, :counter_cache => true
  belongs_to :user, :counter_cache => true
  
  validates_presence_of :product_type_id, :quantity
  validates_numericality_of :product_type_id, :quantity
end
