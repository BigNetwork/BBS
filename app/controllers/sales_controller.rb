class SalesController < ApplicationController
  def index
    @cart = Cart.last
    unless @cart.purchase.nil?  # Get a new cart if the last one is already used
      @cart = Cart.new
      @cart.save(false) # Save the cart so we can get an ID for it (so we can bind CartRows to it later)
    end
    @product_types = ProductType.all
    @purchase = Purchase.new
  end

end
