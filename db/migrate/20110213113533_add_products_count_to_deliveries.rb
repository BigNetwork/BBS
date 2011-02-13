class AddProductsCountToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :products_count, :integer, :default => 0
    
    # Reset counters
    #Delivery.reset_column_information
    #Delivery.find_each do |delivery|
    #  Delivery.reset_counters delivery.id, :products
    #end
  end

  def self.down
    remove_column :deliveries, :products_count
  end
end
