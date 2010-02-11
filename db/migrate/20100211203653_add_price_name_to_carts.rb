class AddPriceNameToCarts < ActiveRecord::Migration
  def self.up
    add_column :carts, :price_name, :string
  end

  def self.down
    remove_column :carts, :price_name
  end
end
