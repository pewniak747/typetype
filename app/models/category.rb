class Category < ActiveRecord::Base
  has_and_belongs_to_many :texts, :uniq => true
  
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.order_by field 
    field ||= ""
    case field.to_sym
    when :name
      return order(:name)
    when :texts
      return all.sort_by { |a| a.texts.size }.reverse
    when :date
      return order(:created_at)
    else
      return all.sort_by { |a| a.texts.size }.reverse
    end
  end
end
