class CreateMemos < ActiveRecord::Migration
  def self.up
    create_table :memos do |t|
      t.text :text
      t.datetime :repeat_at
      t.integer :interval, :default => 1.day.to_i
      t.float :learning_rate, :default => 1
    end
  end

  def self.down
    drop_table :memos
  end
end
