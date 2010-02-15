class AddPurchasePriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :purchase_price, :decimal
  end

  def self.down
    remove_column :products, :purchase_price
  end
end
