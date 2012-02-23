class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :products, :product_type_id
    add_index :products, :purchase_id
    add_index :products, :delivery_id
    add_index :purchases, :cart_id
    add_index :deliveries, :product_type_id
    add_index :cart_rows, :cart_id
  end

  def self.down
    remove_index :products, :column => :product_type_id
    remove_index :products, :column => :purchase_id
    remove_index :products, :column => :delivery_id
    remove_index :purchases, :column => :cart_id
    remove_index :deliveries, :column => :product_type_id
    remove_index :cart_rows, :column => :cart_id
  end
end
