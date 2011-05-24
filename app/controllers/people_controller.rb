class PeopleController < ApplicationController

  respond_to :xml,:html
  before_filter :get_person, :only => [:show, :edit, :destroy, :update]

  def index
    @people = Person.search(params[:email_condition], params[:email], params[:postcode_condition], params[:postcodes])
    respond_with(@people)
  end

  def show
    respond_with(@people)
  end

  def new
    @person = Person.new
    respond_with(@people)
  end

  def edit
  end

  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to(@person, :notice => 'Person was successfully created.') }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy
    respond_with(@people, :location =>people_url)
  end

  private

  def get_person
    @person = Person.find(params[:id])
  end

end
