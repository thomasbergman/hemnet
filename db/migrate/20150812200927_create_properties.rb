class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :url
      t.string :address
      t.string :price
      t.string :area
      t.string :no_of_rooms
      t.string :fee
      t.string :price_per_sqm

      t.timestamps null: false
    end
  end
end
