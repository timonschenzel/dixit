module SessionsHelper
  def sign_in_user(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if(session[:oath] == true)
      @current_user ||= OauthUser.find(session[:user_id]) if session[:user_id]
    elsif(!cookies[:remember_token].nil?)
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end
    #@current_user ||= OauthUser.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out_user
    self.current_user = nil
    session.delete(:user_id)
    session.delete(:oauth)
    cookies.delete(:remember_token)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
