class ChangeColumnType < ActiveRecord::Migration
  
  def change
  	change_column :properties, :price, 'integer USING CAST(price AS integer)'
  end
end
