class AddSoldForPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :sold_for_price, :decimal
  end

  def self.down
    remove_column :products, :sold_for_price
  end
end
