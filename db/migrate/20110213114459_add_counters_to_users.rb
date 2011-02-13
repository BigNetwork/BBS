class AddCountersToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :deliveries_count, :integer, :default => 0
    add_column :users, :purchases_count, :integer, :default => 0
    add_column :users, :carts_count, :integer, :default => 0
    add_column :users, :credits_count, :integer, :default => 0
    
    # Reset counters:
    User.reset_column_information
    #User.find_each do |user|
    #  User.reset_counters user.id, :deliveries
    #  User.reset_counters user.id, :purchases
    #  User.reset_counters user.id, :carts
    #  User.reset_counters user.id, :credits
    #end
  end

  def self.down
    remove_column :users, :credits_count
    remove_column :users, :carts_count
    remove_column :users, :purchases_count
    remove_column :users, :deliveries_count
  end
end
