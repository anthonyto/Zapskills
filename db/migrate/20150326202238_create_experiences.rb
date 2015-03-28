class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :description
      t.date :start_date
      t.integer :level
      t.belongs_to :user, index: true
      t.belongs_to :skill, index: true

      t.timestamps null: false
    end
    add_foreign_key :experiences, :users
    add_foreign_key :experiences, :skills
  end
end
