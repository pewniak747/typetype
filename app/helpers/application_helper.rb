module ApplicationHelper

  def selected_link? link
    if controller_name == "texts"
      return "strong" if link == action_name
    else
      return "strong" if link == @category.id
    end
  end

  def text_icon text
    if text.categories.map { |c| c.name }.include? "songs"
      return image_tag 'vinyl.png'
    else
      return image_tag 'book.png'
    end
  end

  def convert_time time
    "#{time.to_f / 10} s"
  end

end
