class AddSpecialOfferIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :sold_in_special_offer_id, :integer
  end

  def self.down
    remove_column :products, :sold_in_special_offer_id
  end
end
