class ProductTypeRelationsController < ApplicationController

  before_filter :login_required

  # GET /product_type_relations
  # GET /product_type_relations.xml
  def index
    @product_type_relations = ProductTypeRelation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_type_relations }
    end
  end

  # GET /product_type_relations/1
  # GET /product_type_relations/1.xml
  def show
    @product_type_relation = ProductTypeRelation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_type_relation }
    end
  end

  # GET /product_type_relations/new
  # GET /product_type_relations/new.xml
  def new
    @product_type_relation = ProductTypeRelation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_type_relation }
    end
  end

  # GET /product_type_relations/1/edit
  def edit
    @product_type_relation = ProductTypeRelation.find(params[:id])
  end

  # POST /product_type_relations
  # POST /product_type_relations.xml
  def create
    @product_type_relation = ProductTypeRelation.new(params[:product_type_relation])

    respond_to do |format|
      if @product_type_relation.save
        flash[:notice] = 'ProductTypeRelation was successfully created.'
        format.html { redirect_to(@product_type_relation) }
        format.xml  { render :xml => @product_type_relation, :status => :created, :location => @product_type_relation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_type_relation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_type_relations/1
  # PUT /product_type_relations/1.xml
  def update
    @product_type_relation = ProductTypeRelation.find(params[:id])

    respond_to do |format|
      if @product_type_relation.update_attributes(params[:product_type_relation])
        flash[:notice] = 'ProductTypeRelation was successfully updated.'
        format.html { redirect_to(@product_type_relation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_type_relation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_type_relations/1
  # DELETE /product_type_relations/1.xml
  def destroy
    @product_type_relation = ProductTypeRelation.find(params[:id])
    @product_type_relation.destroy

    respond_to do |format|
      format.html { redirect_to(product_type_relations_url) }
      format.xml  { head :ok }
    end
  end
end
