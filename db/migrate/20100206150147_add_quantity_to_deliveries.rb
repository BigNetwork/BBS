class AddQuantityToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :quantity, :integer
  end

  def self.down
    remove_column :deliveries, :quantity
  end
end
