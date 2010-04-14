require 'spec_helper'

describe Memo do
  before :each do
    @valid_attributes = {
      :text => 'something i want to remember'
    }
  end

  it "should create a new instance given valid attributes" do
    Memo.create! @valid_attributes
  end

  it 'should require the text to be set' do
    attributes = @valid_attributes.merge({:text => nil})
    Memo.new(attributes).should_not be_valid
  end

  it 'should remind the user based on progess' do
    memo1 = Memo.create! @valid_attributes
    memo2 = Memo.create! @valid_attributes

    train [memo1, memo2]

    repeat1 = memo1.repeat_at
    repeat2 = memo2.repeat_at

    memo1.forgetting!
    memo2.remembering!

    (memo2.repeat_at - repeat2).should > (memo1.repeat_at - repeat1)
  end

  def train memos
    rand(5).times do
      if rand < 0.5
        memos.each {|memo| memo.forgetting!}
      else
        memos.each {|memo| memo.remembering!}
      end
    end
  end

  describe 'hiding internals' do
    before :each do
      @memo = Memo.new @valid_attributes
    end

    it 'should not allow modification of repeat_at' do
      lambda { @memo.repeat_at = Time.now }.should raise_error
    end

    it 'should not expose interval' do
      lambda { @memo.interval }.should raise_error
      lambda { @memo.interval = 1.day }.should raise_error
    end

    it 'should not expose learning_rate' do
      lambda { @memo.learning_rate }.should raise_error
      lambda { @memo.learning_rate = 1 }.should raise_error
    end
  end
end
