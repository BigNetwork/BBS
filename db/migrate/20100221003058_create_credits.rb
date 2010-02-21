class CreateCredits < ActiveRecord::Migration
  def self.up
    create_table :credits do |t|
      t.integer :purchase_id
      t.integer :user_id
      t.integer :paid_to_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :credits
  end
end
