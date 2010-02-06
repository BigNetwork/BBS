class AddProductTypeToCartRow < ActiveRecord::Migration
  def self.up
    add_column :cart_rows, :product_type_id, :integer
  end

  def self.down
    remove_column :cart_rows, :product_type_id
  end
end
