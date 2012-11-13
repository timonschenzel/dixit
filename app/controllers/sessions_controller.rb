class SessionsController < ApplicationController
  def new
  end

  def create_auth
    #raise request.env["omniauth.auth"].to_yaml
    if (params[:error] != 'access_denied')
      auth = request.env["omniauth.auth"]
      user = OauthUser.find_by_provider_and_uid(auth["provider"], auth["uid"]) || OauthUser.create_with_omniauth(auth)
      session[:user_id] = user.id
      session[:oath] = true
      redirect_to root_url, :notice => "Signed in!"
    else
      redirect_to root_url
    end
  end

  def create
    user = User.find_by_email(params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      # Sign the user in and redirect to the user's show page.
      session[:oath] = false
      sign_in_user user
      redirect_back_or user
    else
      # Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out_user
    redirect_to root_url, :notice => "Signed out!"
  end
end
