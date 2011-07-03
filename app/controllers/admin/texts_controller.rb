class Admin::TextsController < ApplicationController
  
  before_filter :find_text, :except => [:create, :new, :index]
  before_filter :find_category, :only => [:categorize, :uncategorize]

  http_basic_authenticate_with :name => "admin", :password => "typetype"   

  def new
    @text = Text.new
  end

  def create
    @text = Text.create(params[:text])
    if @text.save
      flash[:notice] = "New text added!"
      redirect_to admin_text_path(@text)
    else
      flash[:error] = @text.errors
      redirect_to new_admin_text_path
    end
  end

  def update
    @text.update_attributes(params[:text])
    if @text.save
      flash[:notice] = "Text successfully updated!"
      redirect_to admin_text_path(@text)
    else
      flash[:error] = @text.errors
      redirect_to edit_admin_text_path(@text)
    end
  end

  def show
    conditions = @text.category_ids
    if conditions.empty?
      @available_categories = Category.all
    else
      @available_categories = Category.where('id NOT IN (?)', conditions)
    end
    @available_categories ||= []
  end

  def destroy
    @text.destroy
    flash[:notice] = 'Text successfulfy deleted!'
    redirect_to admin_path
  end

  def categorize
    @text.categories << @category
    # redirect_to admin_text_path(@text)
    redirect_to :back
  end

  def uncategorize
    @text.categories.delete(@category)
    # redirect_to admin_text_path(@text)
    redirect_to :back
  end

  def index
    @texts = Text.includes(:categories).order_by(params[:text_order])
  end

  private

  def find_category
    @category = Category.find(params[:category_id])
    redirect_to text_path(@text) and return if !@category
  end

  def find_text
    @text = Text.find(params[:id] || params[:text_id])
    redirect_to admin_path and return if !@text
  end

end
