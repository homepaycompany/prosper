class CreateAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :accesses do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :company

      t.timestamps
    end
  end
end
