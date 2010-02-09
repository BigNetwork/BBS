class DeliveriesController < ApplicationController
  # GET /deliveries
  # GET /deliveries.xml
  def index
    @deliveries = Delivery.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deliveries }
    end
  end

  # GET /deliveries/1
  # GET /deliveries/1.xml
  def show
    @delivery = Delivery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @delivery }
    end
  end

  # GET /deliveries/new
  # GET /deliveries/new.xml
  def new
    @delivery = Delivery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @delivery }
    end
  end

  # GET /deliveries/1/edit
  def edit
    @delivery = Delivery.find(params[:id])
  end

  # POST /deliveries
  # POST /deliveries.xml
  def create
    @delivery = Delivery.new(params[:delivery])

    respond_to do |format|
      if @delivery.save
        flash[:notice] = 'Delivery was successfully created.'
        
        # Create the delivered products:
        for i in 1..(@delivery.quantity)
          @product = Product.new
          @product.product_type_id = @delivery.product_type_id
          @product.delivery_id = @delivery.id
          @product.save(false)
        end
        
        format.html { redirect_to(@delivery) }
        format.xml  { render :xml => @delivery, :status => :created, :location => @delivery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @delivery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deliveries/1
  # PUT /deliveries/1.xml
  def update
    @delivery = Delivery.find(params[:id])
    
    # TODO: Change the associated Products if the quantity or product type was changed on a Delivery.
    
    respond_to do |format|
      if @delivery.update_attributes(params[:delivery])
        flash[:notice] = 'Delivery was successfully updated.'
        format.html { redirect_to(@delivery) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @delivery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.xml
  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy

    respond_to do |format|
      format.html { redirect_to(deliveries_url) }
      format.xml  { head :ok }
    end
  end
end
