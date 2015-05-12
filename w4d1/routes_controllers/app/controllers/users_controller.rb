class UsersController < ApplicationController


  def create
    @user = User.new( user_params )
    if @user.save
      render json: @user
    else
      render(
      json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    render json: @user
  end

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find_by_id(params[:id])
    render json: @user
  end

  def update
    @user = User.find_by_id(params[:id])

    if @user.update(user_params)
      render json: @user
    else
      render(
      json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  protected

    def user_params
      params.require(:user).permit(:username)
    end
end
