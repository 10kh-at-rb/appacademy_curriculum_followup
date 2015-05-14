class SessionsController < ApplicationController
  skip_before_action :require_logged_in, only: [:new, :create]

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username or password"]
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    log_out!(current_user)
    redirect_to new_session_url
  end

  def new
    @user = User.new
    render :new
  end
end
