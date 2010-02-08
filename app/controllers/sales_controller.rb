class SalesController < ApplicationController
  def index
    @cart = Cart.last
    unless @cart.purchase.nil?  # Get a new cart if the last one is already used
      @cart = Cart.new
      @cart.save(false)
    end
    @product_types = ProductType.all
    @purchase = Purchase.new
  end

end
