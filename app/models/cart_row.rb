class CartRow < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_type
  
  validates_presence_of :product_type_id, :quantity
  validates_numericality_of :product_type_id, :quantity
  
  def sum
    # TODO: Handle crew_price for cart row sums.
    quantity * product_type.standard_price
  end
  
end
