class AddUserIdToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :user_id, :integer
  end

  def self.down
    remove_column :deliveries, :user_id
  end
end
