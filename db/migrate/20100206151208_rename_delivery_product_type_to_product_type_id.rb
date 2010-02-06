class RenameDeliveryProductTypeToProductTypeId < ActiveRecord::Migration
  def self.up
    rename_column :deliveries, :product_type, :product_type_id
  end

  def self.down
    rename_column :deliveries, :product_type_id, :product_type
  end
end
