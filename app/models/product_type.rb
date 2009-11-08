class ProductType < ActiveRecord::Base

  has_many :childings, :foreign_key => 'parent_id', :class_name => 'ProductTypeRelation'
  has_many :children, :through => :childings

  has_many :parentings, :foreign_key => 'child_id', :class_name => 'ProductTypeRelation'
  has_many :parents, :through => :parentings

  has_many :products

end
