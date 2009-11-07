class ProductTypeRelation < ActiveRecord::Base

  belongs_to :parent, :class_name => 'ProductType'
  belongs_to :child, :class_name => 'ProductType'

end
