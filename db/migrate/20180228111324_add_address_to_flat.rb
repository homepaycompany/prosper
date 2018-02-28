class AddAddressToFlat < ActiveRecord::Migration[5.1]
  def change
    add_column :flats, :address, :string
  end
end
