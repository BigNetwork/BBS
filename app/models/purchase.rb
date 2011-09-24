class Purchase < ActiveRecord::Base
  has_many :products
  has_one :credit
  has_many :cart_rows, :through => :cart
  has_many :product_types, :through => :cart, :source => :cart_rows
  belongs_to :cart
  belongs_to :user, :counter_cache => true
  
  def sum
    theSum = 0.0
    for product in products
      theSum += product.sold_for_price
    end
    theSum
  end
  
  def has_credit?
    !credit.nil?
  end
  
  def name
    Purchase.human_name + " " + id.to_s
  end
  
end
