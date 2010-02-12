class AddUserIdToPurchases < ActiveRecord::Migration
  def self.up
    add_column :purchases, :user_id, :integer
  end

  def self.down
    remove_column :purchases, :user_id
  end
end
