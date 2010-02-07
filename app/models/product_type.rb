class ProductType < ActiveRecord::Base

  has_many :childings, :foreign_key => 'parent_id', :class_name => 'ProductTypeRelation'
  has_many :children, :through => :childings

  has_many :parentings, :foreign_key => 'child_id', :class_name => 'ProductTypeRelation'
  has_many :parents, :through => :parentings

  has_many :products
  
  has_many :cart_rows
  
  def not_sold_products
    Product.find(:all, :conditions => { :product_type_id => id, :purchase_id => nil} )
  end
  
  def sold_products
    Product.find(:all, :conditions => ["product_type_id = ? AND purchase_id IS NOT NULL", id] )
  end
  
  def quantity_in_stock
    if children.empty?  # This standard counting method only works for non-combination products: 
      not_sold_products.length
    else
      "?"
      # TODO: Better magic for finding out stock quantity for combination products.
    end
  end
  
  def quantity_sold
    if children.empty?  # This standard counting method only works for non-combination products:
      sold_products.length
    else
      "?"
      # TODO: Better magic for finding out stock quantity for combination products.
    end
  end
  
  def in_stock?
    if quantity_in_stock.to_i && quantity_in_stock.to_i > 0
      true
    else
      false
    end
  end
  
  def combo_purchase_price
    if is_combo?
      total = 0.0
      # TODO: Support for endless loops of childrens childrens children (etc). Did you think recursion? =)
      for child in children
        unless child.purchase_price.nil?
          total += child.purchase_price
        end
      end
      total
    end
  end
  
  def is_combo?
    return !children.empty?
  end

  def profit
    # TODO: Find out if we should compare with crewprice or standard price.
    if is_combo?
      return standard_price - combo_purchase_price
    else
      unless standard_price.nil? || purchase_price.nil?
        return standard_price - purchase_price
      end
    end
  end

end
