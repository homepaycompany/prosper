class CreateFlats < ActiveRecord::Migration[5.1]
  def change
    create_table :flats do |t|
      t.timestamps

      t.string :flat_id
      t.string :origin
      t.datetime :date
      t.string :url
      t.string :title
      t.text :description
      t.integer :price
      t.integer :rooms
      t.integer :surface
      t.integer :plotsurface
      t.references :city, foreign_key: true
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.string :thumbs, array: true
      t.string :images, array: true
      t.string :propertytype
      t.text :pricehistory, array: true
      t.float :avg_price
      t.float :avg_surface
      t.float :avg_plotsurface
      t.float :avg_rooms
      t.float :avg_date
      t.float :investment_return
    end
  end
end
