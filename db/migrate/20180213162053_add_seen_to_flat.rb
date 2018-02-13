class AddSeenToFlat < ActiveRecord::Migration[5.1]
  def change
    add_column :flats, :seen, :boolean, null: false, default: false
  end
end
