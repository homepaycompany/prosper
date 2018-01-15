class CreateFlats < ActiveRecord::Migration[5.1]
  def change
    create_table :flats do |t|
      t.string :title
      t.text :description
      t.string :address
      t.integer :price
      t.float :average_price
      t.integer :size
      t.float :average_size
      t.integer :floor
      t.integer :rooms
      t.float :average_rooms
      t.integer :bedrooms
      t.float :average_bedrooms
      t.datetime :date
      t.string :photo

      t.timestamps
    end
  end
end
