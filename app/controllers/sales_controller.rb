class SalesController < ApplicationController
  
  #before_filter :login_required
  
  def index
    # Get us a price type: 
    if params[:price] == 'crew'
      session[:price_name] = 'crew'
    elsif params[:price] == 'standard'
      session[:price_name] = 'standard'
    else
      if session[:price_name] != 'crew' && session[:price_name] != 'standard'
        session[:price_name] = 'standard'
      end
    end
    
    # Get us a cart:
    @cart = Cart.find_last_by_user_id(current_user.id)
    if @cart.nil? || @cart.purchased  # Get a new cart if noone was found or the last one was already used
      @cart = Cart.new
      if logged_in?
        @cart.user_id = current_user.id
      end
    end
    if @cart.price_name != session[:price_name]
      @cart.price_name = session[:price_name]
      @cart.save(false) # Save the cart so we can get an ID for it (so we can bind CartRows to it later)
    end
    
    # Get us some products:
    @product_types = ProductType.all(:order => :name, :include => [:product_category, :products])
    @purchase = Purchase.new
  end
end
