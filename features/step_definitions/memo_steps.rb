Given /^the memo "([^\"]*)"$/ do |text|
  Memo.create! :text => text
end

Given 'some old memos' do
  (1 + rand(3)).times do |i|
    m = Memo.create! :text => "old memo #{i}"
    m.update_attribute :repeat_at, Time.now - 1.week.to_i * rand
  end
end

Given 'some new memos' do
  (1 + rand(3)).times do |i|
    m = Memo.create! :text => "new memo #{i}"
    m.update_attribute :repeat_at, Time.now + 1.week.to_i * rand
  end
end

Given 'some old and new memos' do
  Given 'some old memos'
  Given 'some new memos'
end

When 'I view a memo' do
  @before_count = Memo.count :conditions => ['repeat_at < ?', Time.now.utc]
  if rand < 0.5
    When 'I press "I\'m gettin it"'
  else
    When 'I press "Dang, I keep forgetting!"'
  end
end

When 'some time passes' do
  @before_count = Memo.to_go
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
