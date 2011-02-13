class Product < ActiveRecord::Base

  belongs_to :product_type#, :counter_cache => true
  belongs_to :delivery, :counter_cache => true
  belongs_to :purchase, :counter_cache => true
  
  validates_presence_of :product_type_id
  
  def sold?
    if purchase.nil?
      return false
    else
      return true
    end
  end
  
  def sold_in_special_offer
    ProductType.find(sold_in_special_offer_id)
  end

end
