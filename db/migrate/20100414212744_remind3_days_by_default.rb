class Remind3DaysByDefault < ActiveRecord::Migration
  def self.up
    change_table :memos do |t|
      t.change :interval, :integer, :default => 3.days.to_i
    end
  end

  def self.down
    change_table :memos do |t|
      t.change :interval, :integer, :default => 1.day.to_i
    end
  end
end
