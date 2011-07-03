module ResultsHelper

  def result_place result
    result.text.results.order("time ASC").index(result)
  end

  def result_place_text result
    place = (result_place result) + 1
    case place
      when 1
        "1st place"
      when 2
        "2nd place"
      when 3
        "3rd place"
      else
        "#{place}th place"
      end
  end

end
