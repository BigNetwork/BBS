class CartRowsController < ApplicationController

  #before_filter :login_required

  # GET /cart_rows
  # GET /cart_rows.xml
  def index
    @cart_rows = CartRow.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cart_rows }
    end
  end

  # GET /cart_rows/1
  # GET /cart_rows/1.xml
  def show
    @cart_row = CartRow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cart_row }
    end
  end

  # GET /cart_rows/new
  # GET /cart_rows/new.xml
  def new
    @cart_row = CartRow.new
    
    unless params[:cart_id].nil?
      @cart_row.cart_id = params[:cart_id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart_row }
    end
  end

  # GET /cart_rows/1/edit
  def edit
    @cart_row = CartRow.find(params[:id])
  end

  # POST /cart_rows
  # POST /cart_rows.xml
  def create
    @cart_row = CartRow.new(params[:cart_row])
    
    # TODO: Only create a new CartRow if there is no other CartRow in the same order with the same product_type_id.
    other_cart_row_found = false
    other_cart_row = CartRow.find(:first, :conditions => { :cart_id => @cart_row.cart_id, :product_type_id => @cart_row.product_type_id })
    
    if other_cart_row.nil?  # No other cart row with this product type, lets go ahead and create this cart row:
      other_cart_row_found = false
    else  # Another cart row found! Change that cart row instead:
      other_cart_row_found = true
      other_cart_row.quantity += @cart_row.quantity
      other_cart_row.save(false)
    end
    
    if other_cart_row.nil?
      if @cart_row.save
        redirect_to(:back)
      else
        respond_to do |format|
          format.html { render :action => "new" }
          format.xml  { render :xml => @cart_row.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to(:back)
    end
    
    #respond_to do |format|
      #unless other_cart_row.nil?
      #  redirect_to(:back)
      #else
    #    if @cart_row.save
          #flash[:notice] = 'CartRow was successfully created.'
    #      format.html { redirect_to(:back) }
    #      format.xml  { render :xml => @cart_row, :status => :created, :location => @cart_row }
    #    else
    #      format.html { render :action => "new" }
    #      format.xml  { render :xml => @cart_row.errors, :status => :unprocessable_entity }
    #    end
      #end
    #end
  end

  # PUT /cart_rows/1
  # PUT /cart_rows/1.xml
  def update
    @cart_row = CartRow.find(params[:id])

    respond_to do |format|
      if @cart_row.update_attributes(params[:cart_row])
        flash[:notice] = 'CartRow was successfully updated.'
        format.html { redirect_to(@cart_row) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart_row.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_rows/1
  # DELETE /cart_rows/1.xml
  def destroy
    @cart_row = CartRow.find(params[:id])
    @cart_row.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
