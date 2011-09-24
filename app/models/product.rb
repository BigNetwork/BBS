class Product < ActiveRecord::Base

  belongs_to :product_type, :counter_cache => true
  belongs_to :delivery, :counter_cache => true
  belongs_to :purchase, :counter_cache => true
  
  validates_presence_of :product_type_id

  def self.total_value
    Product.all.sum do |p|
      if p.purchase_price == nil
        p.product_type.purchase_price
      else
        p.purchase_price
      end
    end
  end
  
  def profit
    if sold_for_price
      sold_for_price - purchase_price
    elsif purchase_price
      product_type.standard_price - purchase_price
    else
      product_type.standard_price - product_type.purchase_price
    end
  end
  
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
