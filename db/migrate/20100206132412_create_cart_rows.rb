class CreateCartRows < ActiveRecord::Migration
  def self.up
    create_table :cart_rows do |t|
      t.integer :cart_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cart_rows
  end
end
