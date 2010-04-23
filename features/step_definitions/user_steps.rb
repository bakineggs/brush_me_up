Given 'a username and password' do
  @login = 'bob'
  @password = 'smells'
  User.create! :login => @login, :password => @password
end

Given 'I am logged in' do
  Given 'a username and password'
  And 'I am on the home page'
  When 'I follow "Log In"'
  And 'I fill in the username and password'
  And 'I press "Log In"'
  Then 'I should see "Log Out"'
end

When 'I fill in the username and password' do
  fill_in 'Login', :with => @login
  fill_in 'Password', :with => @password
end

Then 'I should have memos left to view' do
  doc = Nokogiri::HTML response.body
  doc.at_css('#to_go .count').content.to_i.should > 0
end
