class CatsController < ApplicationController

  def index
    @cats = Cat.all

    render :index
  end

  def new
    @cat = Cat.new

    render :new
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def update
    @cat = Cat.find_by_id(@cat)

    render :edit
  end
end
