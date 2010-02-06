class AddDeliveryIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :delivery_id, :integer
  end

  def self.down
    remove_column :products, :delivery_id
  end
end
