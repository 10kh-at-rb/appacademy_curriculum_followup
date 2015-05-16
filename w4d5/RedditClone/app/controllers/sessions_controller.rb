class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user
      log_in!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Invalid Username or Password"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
