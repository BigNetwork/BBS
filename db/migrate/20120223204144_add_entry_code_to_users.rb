class AddEntryCodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :entry_code, :integer
  end

  def self.down
    remove_column :users, :entry_code
  end
end
