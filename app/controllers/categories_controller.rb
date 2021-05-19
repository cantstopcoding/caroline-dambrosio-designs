class CategoriesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action -> { set(Category) }, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by_id(params[:id])
  end

  def new
  end
end
