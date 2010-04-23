class UserSession < Authlogic::Session::Base
  remember_me true
  remember_me_for 10.years

  def self.for_new_user
    create User.create
  end
end
