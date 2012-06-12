class AttorneysController < ApplicationController

  # Helper for checking if attorney is signed in
  before_filter :signed_in_attorney, only: [:index, :edit, :update, :destroy]

  # Helper for finding attorney based on id sent in params
  # Note: we don't need for edit and update actions because find_attorney
  #       will be called by correct_attorney
  before_filter :find_attorney, only: [:show, :destroy]

  # Helper to prevent attorneys from modifying other attorney profiles
  before_filter :correct_attorney,  only: [:edit, :update]

  # Helper for checking to make sure attorney is admin before deleting other attnys
  before_filter :admin_attorney,     only: :destroy

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
      sign_in @attorney
      flash[:success] = "Welcome to Turnee!" 
      redirect_to @attorney
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end
  
  def update
  	
  	if @attorney.update_attributes(params[:attorney])
  		flash[:success] = "Profile updated"
  		
  		# sign in the attorney because the attorney's remember token 
  		# gets reset when the attorney is saved (see callback in Attorney model)
  		sign_in @attorney
  		redirect_to @attorney
  	else
  		render 'edit'
  	end
  	
  end	
  
  def show
    @referrals = @attorney.referrals
  end
  
  
  def index
    @attorneys = Attorney.paginate(page: params[:page])
  end

  def destroy
    n = @attorney.name
    @attorney.destroy
    flash[:success] = "#{n} has been deleted."
    redirect_to attorneys_path
  end

  protected
  
    def admin_attorney
      redirect_to(root_path) unless current_attorney.admin?
    end
  
  	def find_attorney
		  @attorney = Attorney.find(params[:id])
	  end
	  
	  def signed_in_attorney
	    unless signed_in?
	      store_location #store requested page so we can redirect after sign-in
	      redirect_to signin_path, notice: "Please sign in." unless signed_in?
	    end
	  end
	  
	  def correct_attorney
	    # not sure why I can't use the before_filter here ... 
	    # may be filtering chaining issue?
	    find_attorney
	    redirect_to(root_path) unless current_attorney?(@attorney)
	  end
	    
end
