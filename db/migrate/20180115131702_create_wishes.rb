class CreateWishes < ActiveRecord::Migration[5.1]
  def change
    create_table :wishes do |t|
      t.string :flat_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
