class AddShowtimeToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :showtime1, :datetime
    add_column :properties, :showtime2, :datetime
    add_column :properties, :showtime1_duration, :integer
    add_column :properties, :showtime2_duration, :integer
  end
end
