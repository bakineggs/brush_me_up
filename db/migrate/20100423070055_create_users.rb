class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :persistence_token, :null => false

      t.timestamps
    end

    change_table :memos do |t|
      t.integer :user_id
    end
  end

  def self.down
    drop_table :users

    change_table :memos do |t|
      t.remove :user_id
    end
  end
end
