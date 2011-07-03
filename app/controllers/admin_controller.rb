class AdminController < ApplicationController
  
  http_basic_authenticate_with :name => "admin", :password => "typetype" 
  
  def index
    @texts = Text.includes(:results).includes(:categories).limit(10).order_by(params[:text_order])
    @categories = Category.includes(:texts).limit(10).order_by(params[:category_order])
    @results = Result.by(params[:result_filter]).includes(:text).order("created_at DESC").limit(10)
  end

end
