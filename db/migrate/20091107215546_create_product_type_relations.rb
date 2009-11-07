class CreateProductTypeRelations < ActiveRecord::Migration
  def self.up
    create_table :product_type_relations do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
  end

  def self.down
    drop_table :product_type_relations
  end
end
