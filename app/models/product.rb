class Product < ActiveRecord::Base

  belongs_to :product_type
  belongs_to :delivery
  belongs_to :purchase
  
  validates_presence_of :product_type_id
  
  def sold?
    if purchase.nil?
      return false
    else
      return true
    end
  end

end
