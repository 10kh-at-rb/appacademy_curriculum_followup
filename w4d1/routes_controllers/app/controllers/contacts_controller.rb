class ContactsController < ApplicationController
  def create
    @contact = Contact.new( contact_params )
    if @contact.save
      render json: @contact
    else
      render(
      json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @contact = Contact.find_by_id(params[:id])
    @contact.destroy
    render json: @contact
  end

  def index
    @contacts = Contact.all
    render json: @contacts
  end

  def show
    @contact = Contact.find_by_id(params[:id])
    render json: @contact
  end

  def update
    @contact = Contact.find_by_id(params[:id])

    if @contact.update(user_params)
      render json: @contact
    else
      render(
      json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  protected

    def contact_params
      params.require(:contact).permit(:email, :name, :user_id)
    end
end
