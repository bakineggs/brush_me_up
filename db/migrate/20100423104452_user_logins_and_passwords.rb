class UserLoginsAndPasswords < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :login, :null => true
      t.string :crypted_password, :null => true
      t.string :password_salt, :null => true
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :login
      t.remove :crypted_password
      t.remove :password_salt
    end
  end
end
