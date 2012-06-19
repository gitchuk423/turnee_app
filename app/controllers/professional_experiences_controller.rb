class ProfessionalExperiencesController < ApplicationController 
 
  before_filter :signed_in_attorney
  before_filter :correct_attorney, only: :destroy
  

  
  def new
    @professional_experience = current_attorney.professional_experiences.new 
  end
  
  # This action uses POST parameters. They are most likely coming
  # from an HTML form which the user has submitted. The URL for
  # this RESTful request will be "/attorneys", and the data will be
  # sent as part of the request body.
  def create
    
    @professional_experience = current_attorney.professional_experiences.new(params[:professional_experience])
    
    if @professional_experience.save
      redirect_to current_attorney
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end
  
  def subregion_options
    render partial: 'shared/subregion_select'
  end

end

