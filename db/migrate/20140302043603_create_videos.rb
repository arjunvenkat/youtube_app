class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.integer :duration

      t.timestamps
    end
  end
end
