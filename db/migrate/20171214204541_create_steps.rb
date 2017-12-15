class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :resources

      t.timestamps
    end
  end
end
