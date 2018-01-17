class AddLandSizeToFlat < ActiveRecord::Migration[5.1]
  def change
    add_column :flats, :land_size, :string
  end
end
