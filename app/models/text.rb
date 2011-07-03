class Text < ActiveRecord::Base
  
  has_and_belongs_to_many :categories, :uniq => true
  has_many :results, :dependent => :destroy

  validates_presence_of :author, :title, :body
  validate :correct_body

  before_save :calculate_words_count

  def self.order_by field 
    field ||= ""
    case field.to_sym
    when :title
      return self.order(:title)
    when :author
      return self.order(:author)
    when :popularity
      return self.all.sort_by { |t| t.results.size }.reverse
    when :date
      return self.order(:created_at)
    when :words
      return self.order(:words_count)
    else
      return self.order(:created_at)
    end
  end

  private

  def calculate_words_count
    self.words_count = self.body.split.size
  end

  def correct_body
    true
  end
end
