module SessionsHelper
  
  
  def sign_in(attorney)
    cookies.permanent[:remember_token] = attorney.remember_token
    current_attorney = attorney
  end
  
  def sign_out
  	current_attorney = nil
  	cookies.delete(:remember_token)
  end

  def signed_in?
  	!current_attorney.nil?
  end

  def current_attorney=(attorney)
    @current_attorney = attorney
  end 
  
  def signed_in_attorney
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def current_attorney
    @current_attorney ||= Attorney.find_by_remember_token(cookies[:remember_token])
  end

  def current_attorney?(attorney)
    attorney == current_attorney
  end

  def redirect_back_or(default)
    # redirect to requested page if possible, else use parameter 
    redirect_to(session[:return_to] || default)
    # we've redirected user to requested page, so don't need to store anymore
    session.delete(:return_to)
  end
  
  def store_location
    # store the location of the requested page in session facility
    # (expires upon browser closing)
    session[:return_to] = request.fullpath
  end

end
