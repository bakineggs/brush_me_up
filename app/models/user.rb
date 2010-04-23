class User < ActiveRecord::Base
  acts_as_authentic
  has_many :memos, :order => :repeat_at
end
