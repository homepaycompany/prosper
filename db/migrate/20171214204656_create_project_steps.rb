class CreateProjectSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :project_steps do |t|
      t.references :project, foreign_key: true
      t.references :step, foreign_key: true

      t.timestamps
    end
  end
end
