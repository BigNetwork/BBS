class ProductType < ActiveRecord::Base

  has_many :childings, :foreign_key => 'parent_id', :class_name => 'ProductTypeRelation'
  has_many :children, :through => :childings

  has_many :parentings, :foreign_key => 'child_id', :class_name => 'ProductTypeRelation'
  has_many :parents, :through => :parentings

  has_many :products
  has_many :cart_rows
  has_many :deliveries
  
  belongs_to :product_category
  
  default_scope :order => 'name'
  
  validates_presence_of :name, :purchase_price, :standard_price#, :crew_price
  
  def self.all_non_special_offers
    ProductType.all(:conditions => "product_types.id NOT IN (SELECT product_type_relations.parent_id AS id FROM product_type_relations)", :order => :name)
  end
  
  def not_sold_products
    Product.find(:all, :conditions => { :product_type_id => id, :purchase_id => nil} )
  end
  
  def color
    if product_category
      if product_category.color
        product_category.color
      else
        'darkblue'
      end
    else
      'black'
    end
  end
  
  def sold_products
    Product.find(:all, :include => :product_type, :conditions => ["product_type_id = ? AND purchase_id IS NOT NULL", id])
  end
  
  def sold_sum
    ProductType.sum(:sold_for_price, :include => :products, :conditions => ["product_type_id = ? AND purchase_id IS NOT NULL", id])
  end
  
  def profit_sum
    ProductType.sum('sold_for_price - products.purchase_price', :include => :products, :conditions => ["product_type_id = ? AND purchase_id IS NOT NULL", id])
  end
  
  def purchase_sum
    ProductType.sum('products.purchase_price', :include => :products, :conditions => ["product_type_id = ? AND purchase_id IS NOT NULL", id])
  end
  
  def quantity_delivered
    if is_combo? 
      child_instances = Array.new
      child_in_stock = Array.new
      
      for child in children
        if child_instances[child.id].nil?
          child_instances[child.id] = 1
          child_in_stock[child.id] = child.quantity_delivered
        else
          child_instances[child.id] += 1
        end
      end
      qty = 0
      fiskarray = Array.new
      for child in children
        fiskarray.push child_in_stock[child.id] / child_instances[child.id]
      end
      # Find the lower denominator in the products stocks:
      lowest = -1
      for item in fiskarray
        if lowest == -1
          lowest = item
        elsif item < lowest
          lowest = item
        end
      end
      return lowest
    else
      products.size
    end
  end
  
  def quantity_in_stock
    if is_combo?
      child_instances = Array.new
      child_in_stock = Array.new
      
      for child in children
        if child_instances[child.id].nil?
          child_instances[child.id] = 1
          child_in_stock[child.id] = child.quantity_in_stock
        else
          child_instances[child.id] += 1
        end
      end
      qty = 0
      fiskarray = Array.new
      for child in children
        fiskarray.push child_in_stock[child.id] / child_instances[child.id]
      end
      # Find the lower denominator in the products stocks:
      lowest = -1
      for item in fiskarray
        if lowest == -1
          lowest = item
        elsif item < lowest
          lowest = item
        end
      end
      return lowest
    else
      not_sold_products.size
    end
  end
  
  def quantity_sold
    if is_combo?
      sold_products.size
    else
      sold_products.size
    end
  end
  
  def in_stock?
    if is_combo?
      child_instances = Array.new
      child_in_stock = Array.new
      
      for child in children
        if child_instances[child.id].nil?
          child_instances[child.id] = 1
          child_in_stock[child.id] = child.quantity_in_stock
        else
          child_instances[child.id] += 1
        end
      end
      # är amount > in stock? returnera false
      for child in children
        if child_instances[child.id] > child_in_stock[child.id]
          return false
        end
      end
      true
    else
      if quantity_in_stock.to_i && quantity_in_stock.to_i > 0
        true
      else
        false
      end
    end
  end
  
  def combo_purchase_price
    if is_combo?
      total = 0.0
      # TODO: Support for endless loops of childrens childrens children (etc). Did you think recursion? =)
      for child in children
        unless child.purchase_price.nil?
          total += child.combo_purchase_price
        end
      end
      total
    else
      purchase_price
    end
  end
  
  def is_combo?
    !children.empty?
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
  
  def sold_per_hour
    times = Array.new
    for product in sold_products
      hour = product.purchase.created_at.to_s[11,2].to_i
      if times[hour].nil?
        times[hour] = 1
      else
        times[hour] += 1
      end
    end
    times = times.map do |time|
      if time.nil?
        time = 0 if time.nil?
      else
        time = time
      end
    end
    times
  end

end
