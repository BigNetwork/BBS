class CartRow < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_type
  
  validates_presence_of :product_type_id, :quantity
  validates_numericality_of :product_type_id, :quantity
  
  def sum
    unless cart.nil?
      if cart.price_name == 'standard'
        quantity * product_type.standard_price
      elsif cart.price_name == 'crew'
        quantity * product_type.crew_price
      else
        quantity * product_type.standard_price
      end
    end
  end
  
end
