class Admin::ResultsController < ApplicationController

  before_filter :find_result, :except => :index

  http_basic_authenticate_with :name => "admin", :password => "typetype"   

  def index
    @results = Result.includes(:texts).by(params[:result_filter]).order("created_at DESC")
  end
  
  def update
    @result.update_attribute(:cheat, params[:cheat])
    @result.save
    redirect_to admin_path
  end

  def destroy
    @result.destroy
    redirect_to admin_path
  end


  private

  def find_result
    @result = Result.unscoped.find(params[:id])
    redirect_to admin_path and return if !@result
  end

end
