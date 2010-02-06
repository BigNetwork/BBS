class AddProductTypeIdToDelivery < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :product_type, :integer
  end

  def self.down
    remove_column :deliveries, :product_type
  end
end
