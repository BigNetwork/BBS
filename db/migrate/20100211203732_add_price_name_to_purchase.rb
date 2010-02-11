class AddPriceNameToPurchase < ActiveRecord::Migration
  def self.up
    add_column :purchases, :price_name, :string
  end

  def self.down
    remove_column :purchases, :price_name
  end
end
