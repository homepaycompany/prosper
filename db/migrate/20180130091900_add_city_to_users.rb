class AddCityToUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :zip_code

      t.timestamps
    end

    create_table :city_accesses do |t|
      t.references :user, foreign_key: true
      t.references :city, foreign_key: true
      t.datetime :starts_at
      t.integer :duration

      t.timestamps
    end
  end
end
