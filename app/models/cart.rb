class Cart < ActiveRecord::Base
  has_many :cart_rows, :dependent => :destroy
  has_many :product_types, :through => :cart_rows
  has_one :purchase
  belongs_to :user
  
  def self.find_last_by_user_id(user_id)
    Cart.last(:conditions => { :user_id => user_id })
  end
  
  def sum
    total = 0.0
    for row in cart_rows
      total += row.sum
    end
    total
  end
  
  def total_quantity
    quantity = 0
    for row in cart_rows
      quantity += row.quantity
    end
    quantity
  end
  
  def purchased
    return !purchase.nil?
  end
  
end
