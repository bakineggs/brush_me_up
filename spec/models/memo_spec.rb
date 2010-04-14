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

    Time.stub!(:now).and_return([repeat1, repeat2].max)

    memo1.forgetting!
    memo2.remembering!

    (memo2.repeat_at - repeat2).should > (memo1.repeat_at - repeat1)
  end

  it 'should always set the next repeat_at in the future' do
    memo = Memo.create! @valid_attributes
    first_repeat = memo.repeat_at
    Time.stub!(:now).and_return(first_repeat + 1.month)
    memo.forgetting!
    memo.repeat_at.should > Time.now
  end

  it 'should provide the next memo' do
    memos = []
    (1+rand(4)).times do
      memo = Memo.create! @valid_attributes
      train [memo]
      memos.push memo
    end
    Memo.next.should == memos.sort_by(&:repeat_at).first
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
end
