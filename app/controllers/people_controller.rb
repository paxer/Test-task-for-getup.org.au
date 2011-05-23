class PeopleController < ApplicationController

  respond_to :xml,:html

  def index
    @people = Person.search(params[:email], params[:condition], params[:postcodes])
    respond_with(@people)
  end

  def show
    @person = Person.find(params[:id])
    respond_with(@people)
  end

  def new
    @person = Person.new
    respond_with(@people)
  end

  def edit
    @person = Person.find(params[:id])
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
    @person = Person.find(params[:id])

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
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end

  def search
    #@people = Person.where(:email => params[:email])
    #@people = Person.all
    @people = Person.where(:email => "ck@hotmail.com")
    logger.debug "params iss #{params[:email]} + #{params[:term]}"
    render :action => 'index'
  end

end
