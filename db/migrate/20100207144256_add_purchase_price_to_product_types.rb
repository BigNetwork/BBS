class AddPurchasePriceToProductTypes < ActiveRecord::Migration
  def self.up
    add_column :product_types, :purchase_price, :decimal
  end

  def self.down
    remove_column :product_types, :purchase_price
  end
end
