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

  def current_attorney
    @current_attorney ||= Attorney.find_by_remember_token(cookies[:remember_token])
  end

end
