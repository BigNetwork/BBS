class AddPurchaseIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :purchase_id, :integer
  end

  def self.down
    remove_column :products, :purchase_id
  end
end
