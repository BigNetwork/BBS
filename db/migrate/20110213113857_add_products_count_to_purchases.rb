class AddProductsCountToPurchases < ActiveRecord::Migration
  def self.up
    add_column :purchases, :products_count, :integer, :default => 0
    
    # Reset counters
    #Purchase.reset_column_information
    #Purchase.find_each do |purchase|
    #  Purchase.reset_counters purchase.id, :products
    #end
  end

  def self.down
    remove_column :purchases, :products_count
  end
end
