class TextsController < ApplicationController

  before_filter :find_text, :only => :show
  before_filter :find_categories

  def index
    @texts = Text.includes(:categories).all    
  end

  def popular
    @texts = Text.includes(:categories).includes(:results).order_by(:popularity)
    render 'index' 
  end

  def show
    respond_to do |format|
      format.html
      format.json {render :json => @text, :layout => false}
    end
  end

  def fresh
    @texts = Text.includes(:categories).order_by(:created_at)
    render 'index'
  end
  
  private

  def find_text
    @text = Text.find(params[:id])
    redirect_to root_path and return if !@text
  end

  def find_categories
    @categories = Category.includes(:texts).order_by(:texts)
  end

end
