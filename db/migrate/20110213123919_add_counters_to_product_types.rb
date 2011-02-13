class AddCountersToProductTypes < ActiveRecord::Migration
  def self.up
    add_column :product_types, :products_count, :integer, :default => 0
    add_column :product_types, :cart_rows_count, :integer, :default => 0
    add_column :product_types, :deliveries_count, :integer, :default => 0
    
    # Reset counters:
    #ProductType.reset_column_information
    #ProductType.find_each do |product_type|
    #  ProductType.reset_counters product_type.id, :products
    #  ProductType.reset_counters product_type.id, :cart_rows
    #  ProductType.reset_counters product_type.id, :deliveries
    #end
  end

  def self.down
    remove_column :product_types, :deliveries_count
    remove_column :product_types, :cart_rows_count
    remove_column :product_types, :products_count
  end
end
