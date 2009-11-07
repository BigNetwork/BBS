class CreateProductTypes < ActiveRecord::Migration
  def self.up
    create_table :product_types do |t|
      t.string :name
      t.text :description
      t.decimal :standard_price
      t.decimal :crew_price

      t.timestamps
    end
  end

  def self.down
    drop_table :product_types
  end
end
