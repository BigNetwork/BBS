class PurchasesController < ApplicationController

  before_filter :login_required

  # GET /purchases
  # GET /purchases.xml
  def index
    @purchases = Purchase.all(:order => "id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @purchases }
    end
  end

  # GET /purchases/1
  # GET /purchases/1.xml
  def show
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  # GET /purchases/new
  # GET /purchases/new.xml
  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  # GET /purchases/1/edit
  def edit
    @purchase = Purchase.find(params[:id])
  end

  # POST /purchases
  # POST /purchases.xml
  def create
    @purchase = Purchase.new(params[:purchase])
    @purchase.price_name = session[:price_name]
    if logged_in?
      @purchase.user_id = current_user.id
    end

    respond_to do |format|
      if @purchase.save
        flash[:notice] = t('Purchase was successfully created')
        
        bind_products
        
        format.html { redirect_to(:back) }
        format.xml  { render :xml => @purchase, :status => :created, :location => @purchase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /purchases/1
  # PUT /purchases/1.xml
  def update
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        flash[:notice] = t('Purchase was successfully updated.')
        format.html { redirect_to(@purchase) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.xml
  def destroy
    @purchase = Purchase.find(params[:id])
    
    # TODO: Release all products that were bound to this purchase.
    
    for product in @purchase.products
      product.purchase_id = nil
      product.save(false)
    end
    
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to(purchases_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
    def bind_products

      # If we know the cart, snatch products that match that cart:
      unless @purchase.cart_id.nil?
        @cart = Cart.find_by_id(@purchase.cart_id)  
        for cart_row in @cart.cart_rows
          # Find some products to snatch:
          for i in 1..cart_row.quantity
            product = Product.find_by_product_type_id(cart_row.product_type, :conditions => { :purchase_id => nil} )
            unless product.nil?
                product.purchase_id = @purchase.id
                # FIXME: This is EXTREMELY ugly (with dynamic variable names). And not to say inreliable.
                if @purchase.price_name == 'standard' || @purchase.price_name == 'crew'
                  product.sold_for_price = product.product_type.send("#{ @purchase.price_name }_price")
                end
                product.purchase_price = product.product_type.purchase_price
                product.save(false)
            else
                # Problem, not enough products of that type available!
                flash[:error] = "Problem! Not enough #{cart_row.product_type.name} available in stock!"
            end
          end
        end
      end

    end
  
end
