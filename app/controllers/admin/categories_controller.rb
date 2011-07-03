class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with :name => "admin", :password => "typetype"   

  before_filter :find_category, :only => [:edit, :destroy, :update, :show]
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.create(params[:category])
    if @category.save
      flash[:notice] = "New category added!"
      redirect_to admin_path
    else
      flash[:error] = @category.errors
      redirect_to new_admin_category_path
    end
  end

  def update
    @category.update_attributes(params[:category])
    if @category.save
      flash[:notice] = "Category successfully updated!"
      redirect_to admin_path
    else
      flash[:error] = @category.errors
      redirect_to edit_admin_category_path(@category)
    end
  end

  def destroy
    @category.delete
    flash[:notice] = 'Category successfulfy deleted!'
    redirect_to admin_path
  end

  def index
    @categories = Category.includes(:texts).sort_by { |a| a.texts.size }.reverse
  end

  private

  def find_category
    @category = Category.find(params[:id])
    redirect_to admin_path and return if !@category
  end
end
