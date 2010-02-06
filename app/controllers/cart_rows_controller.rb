class CartRowsController < ApplicationController
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

    respond_to do |format|
      if @cart_row.save
        flash[:notice] = 'CartRow was successfully created.'
        format.html { redirect_to(@cart_row) }
        format.xml  { render :xml => @cart_row, :status => :created, :location => @cart_row }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart_row.errors, :status => :unprocessable_entity }
      end
    end
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
      format.html { redirect_to(cart_rows_url) }
      format.xml  { head :ok }
    end
  end
end
