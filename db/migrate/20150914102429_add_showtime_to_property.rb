class AddShowtimeToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :showtime1, :datetime
    add_column :properties, :showtime1_start, :time
    add_column :properties, :showtime1_end, :time
    add_column :properties, :showtime1_duration, :integer
   
    
    add_column :properties, :showtime2, :datetime
    add_column :properties, :showtime2_start, :time
    add_column :properties, :showtime2_end, :time
    add_column :properties, :showtime2_duration, :integer
	end
end
