class Result < ActiveRecord::Base
  
  belongs_to :text

  validates_presence_of :name, :time, :text_id
  validate :validate_time

  default_scope where(:cheat => false)

  def self.whole
    self.unscoped
  end

  def self.cheats
    where(:cheat => true)
  end

  def self.by result_filter
    if result_filter == "all"
      self.unscoped
    elsif result_filter == "cheat"
      self.where(:cheat => true)
    else
      self
    end
  end

  def wpm
    words = text.words_count
    minutes = time.to_f / 600
    (words / minutes).to_i
  end

  private

  def validate_time
    errors.add(:time, "Time must be greater than 0") if time <= 0
  end

end
