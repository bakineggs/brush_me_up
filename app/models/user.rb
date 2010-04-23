class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.validate_login_field false
    config.validate_password_field false
  end

  has_many :memos, :order => :repeat_at

  def absorb other
    other.memos.each {|memo| memo.update_attribute :user_id, id}
    other.destroy
  end
end
