class AddCoinsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :coins, :integer, :default => 0
  end

  def self.down
    remove_column :users, :coins
  end
end
