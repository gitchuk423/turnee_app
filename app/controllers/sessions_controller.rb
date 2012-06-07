class SessionsController < ApplicationController

  def new
  	
  end

  def create
  	attorney = Attorney.find_by_email(params[:session][:email])
    if attorney && attorney.authenticate(params[:session][:password])
      # Sign the attorney in and redirect to the attorney's show page.
      sign_in attorney
      redirect_to attorney
    else
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  	
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
  
end
