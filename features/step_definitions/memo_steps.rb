Given 'I found my user account' do
  unless @user
    Given 'I am on the home page'
    @user = User.find_by_persistence_token response.session['user_credentials']
  end
end

Given /^my memo "([^\"]*)"$/ do |text|
  Given 'I found my user account'
  @user.memos.create :text => text
end

Given "some other peoples' memos" do
  (1 + rand(3)).times do |i|
    Memo.create! :text => "other person's #{i}", :user => User.create!
  end
end

Given 'I have some old memos' do
  Given 'I found my user account'
  (1 + rand(3)).times do |i|
    m = @user.memos.create! :text => "old memo #{i}"
    m.update_attribute :repeat_at, Time.now - 1.week.to_i * rand
  end
end

Given 'I have some new memos' do
  Given 'I found my user account'
  (1 + rand(3)).times do |i|
    m = @user.memos.create! :text => "new memo #{i}"
    m.update_attribute :repeat_at, Time.now + 1.week.to_i * rand
  end
end

Given 'I have some old and new memos' do
  Given 'I have some old memos'
  Given 'I have some new memos'
end

When 'I view a memo' do
  @before_count = @user.memos.to_go.count
  if rand < 0.5
    When 'I press "I\'m gettin it"'
  else
    When 'I press "Dang, I keep forgetting!"'
  end
end

When 'some time passes' do
  @before_count = @user.memos.to_go.count
  upcoming = Memo.first :order => :repeat_at, :conditions => ['repeat_at > ?', Time.now]
  Time.stub!(:now).and_return(upcoming.repeat_at + 1.minute)
end

Then 'I should be told how many memos are left to see' do
  count = Memo.count :conditions => ['repeat_at <= ?', Time.now.utc]
  doc = Nokogiri::HTML response.body
  doc.at_css('#to_go .count').content.should == count.to_s
end

Then 'there should be one less memo left to view' do
  doc = Nokogiri::HTML response.body
  doc.at_css('#to_go .count').content.should == (@before_count - 1).to_s
end

Then 'there should be more memos left to view' do
  doc = Nokogiri::HTML response.body
  doc.at_css('#to_go .count').content.to_i.should > @before_count
end
