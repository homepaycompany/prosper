class AddVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.references :flat, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    remove_column :flats, :seen
  end
end
