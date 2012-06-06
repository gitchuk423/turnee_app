class AttorneysController < ApplicationController
  
  def show
    @attorney = Attorney.find(params[:id])
  end

  def new
    @attorney = Attorney.new
    @attorney.build_personal_record
    @attorney.build_professional_record
  end

  # This action uses POST parameters. They are most likely coming
  # from an HTML form which the user has submitted. The URL for
  # this RESTful request will be "/attorneys", and the data will be
  # sent as part of the request body.
  def create
    @attorney = Attorney.new(params[:attorney])
    if @attorney.save
      flash[:success] = "Welcome to Turnee!" 
      redirect_to @attorney
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end

end
