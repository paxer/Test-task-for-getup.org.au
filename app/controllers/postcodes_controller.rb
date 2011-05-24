class PostcodesController < ApplicationController

  respond_to :xml,:html
  before_filter :get_postcode, :only => [:show, :edit, :destroy, :update]

  def index
    @postcodes = Postcode.all
    respond_with(@postcodes)
  end

  def show
    respond_with(@postcodes)
  end

  def new
    @postcode = Postcode.new
    respond_with(@postcodes)
  end

  def edit
  end

  def create
    @postcode = Postcode.new(params[:postcode])

    respond_to do |format|
      if @postcode.save
        format.html { redirect_to(@postcode, :notice => 'Postcode was successfully created.') }
        format.xml  { render :xml => @postcode, :status => :created, :location => @postcode }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @postcode.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @postcode.update_attributes(params[:postcode])
        format.html { redirect_to(@postcode, :notice => 'Postcode was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @postcode.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @postcode.destroy
    respond_with(@people, :location =>postcodes_url)
  end

  private

  def get_postcode
    @postcode = Postcode.find(params[:id])
  end

end
