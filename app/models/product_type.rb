class ProductType < ActiveRecord::Base

  has_many :childings, :foreign_key => 'parent_id', :class_name => 'ProductTypeRelation'
  has_many :children, :through => :childings

  has_many :parentings, :foreign_key => 'child_id', :class_name => 'ProductTypeRelation'
  has_many :parents, :through => :parentings

  has_many :products
  
  has_many :cart_rows
  
  def quantity_in_stock
    if children.empty?
      products.count
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

end
