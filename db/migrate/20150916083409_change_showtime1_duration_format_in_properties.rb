class ChangeShowtime1DurationFormatInProperties < ActiveRecord::Migration
  def change
    change_column :properties, :showtime1_duration, 'integer USING CAST(showtime1_duration AS integer)'
  end
end
