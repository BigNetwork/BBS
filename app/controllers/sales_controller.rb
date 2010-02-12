class SalesController < ApplicationController
  
  before_filter :login_required
  
  def index
    @cart = Cart.find_last_by_user_id(current_user.id)
    #@cart = Cart.last
    if @cart.purchased  # Get a new cart if the last one is already used
      @cart = Cart.new
      if logged_in?
        @cart.user_id = current_user.id
      end
      @cart.save(false) # Save the cart so we can get an ID for it (so we can bind CartRows to it later)
    end
    @product_types = ProductType.all
    @purchase = Purchase.new
  end
end
