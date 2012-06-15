class SessionsController < ApplicationController


  def create
  	attorney = Attorney.find_by_email(params[:session][:email])
    if attorney && attorney.authenticate(params[:session][:password])
      
      sign_in attorney
      
      # Redirect back to page requested before sign-in or attoney's profile page
      redirect_back_or root_path
    else
      flash[:error] = 'Invalid email/password combination' 
      render 'new'
    end
  	
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
  
end
