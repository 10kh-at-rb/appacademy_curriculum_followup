class CatRentalRequestsController < ApplicationController

  def approve
    find_by_id(params[:id]).approve!
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      @cat = Cat.find_by_id(@cat_rental_request.cat_id)
      redirect_to cat_url(@cat)
    else
      render json: @cat_rental_request.errors.full_messages, status: :unprocessable_entity
    end
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
