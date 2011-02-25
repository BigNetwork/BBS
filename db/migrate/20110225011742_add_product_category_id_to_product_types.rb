class AddProductCategoryIdToProductTypes < ActiveRecord::Migration
  def self.up
    add_column :product_types, :product_category_id, :integer
  end

  def self.down
    remove_column :product_types, :product_category_id
  end
end
