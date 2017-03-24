class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.text :name
      t.text :description
      t.text :status
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
