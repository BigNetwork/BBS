class Purchase < ActiveRecord::Base
  has_many :products
  belongs_to :cart
  belongs_to :user
  
  def sum
    # TODO: Check for crew or standard price!
    theSum = 0.0
    
    for product in products
      if price_name == 'standard'
        theSum += product.product_type.standard_price
      elsif price_name == 'crew'
        theSum += product.product_type.crew_price
      else
        #theSum += product.product_type.standard_price
      end
    end
    
    theSum
  end
end
