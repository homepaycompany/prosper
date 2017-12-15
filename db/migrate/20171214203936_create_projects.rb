class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :segment
      t.string :subsegment

      t.timestamps
    end
  end
end
