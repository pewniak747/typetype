class ResultsController < ApplicationController

  def new
    @text = Text.find(params[:id])
    @result = Result.new
  end

  def create
    @text = Text.find(params[:id])
    @result = @text.results.create(params[:result])
    if @result.valid?
      render 'create', :layout => false
    else
      render 'error', :layout => false
    end
  end
end
