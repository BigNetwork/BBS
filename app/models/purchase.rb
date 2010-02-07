class Purchase < ActiveRecord::Base
  has_many :products
  belongs_to :cart
  
  def sum
    # TODO: Check for crew or standard price!
    theSum = 0.0
    
    for product in products
      theSum += product.product_type.standard_price
    end
    
    theSum
  end
end
