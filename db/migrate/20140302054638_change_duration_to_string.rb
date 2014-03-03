class ChangeDurationToString < ActiveRecord::Migration
  def change
    change_column :videos, :duration, :string
  end
end
