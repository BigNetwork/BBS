class AddBlsIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :bls_id, :integer
  end

  def self.down
    remove_column :users, :bls_id
  end
end
