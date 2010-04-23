class Memo < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :text
  before_create :set_repeat_at

  named_scope :to_go, lambda {
    { :conditions => ['repeat_at <= ?', Time.now.utc] }
  }

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
