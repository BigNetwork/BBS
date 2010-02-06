class AddCartIdToPurchase < ActiveRecord::Migration
  def self.up
    add_column :purchases, :cart_id, :integer
  end

  def self.down
    remove_column :purchases, :cart_id
  end
end
