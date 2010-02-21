class CreditsController < ApplicationController
  # GET /credits
  # GET /credits.xml
  def index
    @credits = Credit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @credits }
    end
  end

  # GET /credits/1
  # GET /credits/1.xml
  def show
    @credit = Credit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @credit }
    end
  end

  # GET /credits/new
  # GET /credits/new.xml
  def new
    @credit = Credit.new
    unless params[:purchase_id].nil?
      @credit.purchase_id = params[:purchase_id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @credit }
    end
  end

  # GET /credits/1/edit
  def edit
    @credit = Credit.find(params[:id])
    unless params[:paid_to_user_id].nil?
      @credit.paid_to_user_id = params[:paid_to_user_id]
    end
  end

  # POST /credits
  # POST /credits.xml
  def create
    @credit = Credit.new(params[:credit])

    respond_to do |format|
      if @credit.save
        flash[:notice] = 'Credit was successfully created.'
        format.html { redirect_to(purchase_path(@credit.purchase_id)) }
        format.xml  { render :xml => @credit, :status => :created, :location => @credit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @credit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /credits/1
  # PUT /credits/1.xml
  def update
    @credit = Credit.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        flash[:notice] = 'Credit was successfully updated.'
        format.html { redirect_to(purchase_path(@credit.purchase.id)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @credit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /credits/1
  # DELETE /credits/1.xml
  def destroy
    @credit = Credit.find(params[:id])
    @credit.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
