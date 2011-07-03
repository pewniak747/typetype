module AdminHelper

  def texts_count
    Text.count
  end

  def categories_count
    Category.count
  end

  def results_count filter=nil
    Result.by(filter || params[:result_filter]).count
  end
end
