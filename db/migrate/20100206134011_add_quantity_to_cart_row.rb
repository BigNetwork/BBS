class AddQuantityToCartRow < ActiveRecord::Migration
  def self.up
    add_column :cart_rows, :quantity, :integer
  end

  def self.down
    remove_column :cart_rows, :quantity
  end
end
