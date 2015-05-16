class SubsController < ApplicationController
  before_action :herd_user

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      flash[:success] = "Success updated"
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @sub.errors.full_messages
    end
  end


  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
