class Memo < ActiveRecord::Base
  validates_presence_of :text
  before_create :set_repeat_at

  def self.next
    first :order => :repeat_at
  end

  def forgetting!
    self.learning_rate -= 0.2 if learning_rate > 1.5
    self.learning_rate -= 0.1
    set_next_repetition!
  end

  def remembering!
    self.learning_rate += 0.1
    set_next_repetition!
  end

  private
    attr_accessor :interval, :learning_rate
    attr_writer :repeat_at

    def set_repeat_at
      self.repeat_at = Time.now
    end

    def set_next_repetition!
      self.learning_rate = 0.5 if learning_rate < 0.5
      self.interval = [1.day.to_i, [interval * learning_rate, 90.days.to_i].min].max
      self.repeat_at = Time.now + interval
      save!
    end
end
