module TextsHelper

  def medal_image place
    place += 1
    image_tag "medal_#{place}.png" if (1..3).include? place
  end

end
