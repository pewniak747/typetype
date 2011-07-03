class CategoriesController < ApplicationController

  before_filter :find_category


  def show
    @texts = @category.texts 
  end

  private

  def find_category
    @categories = Category.includes(:texts).order_by(:texts)
    @category = Category.find(params[:id])
    redirect_to root_url and return if !@category
  end
end
