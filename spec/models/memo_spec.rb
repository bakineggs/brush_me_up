require 'spec_helper'

describe Memo do
  before(:each) do
    @valid_attributes = {
      :text => 'something i want to remember'
    }
  end

  it "should create a new instance given valid attributes" do
    Memo.create!(@valid_attributes)
  end

  it 'should require the text to be set' do
    attributes = @valid_attributes.merge({:text => nil})
    Memo.new(attributes).should_not be_valid
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
