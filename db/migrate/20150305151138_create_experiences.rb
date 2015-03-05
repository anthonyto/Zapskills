class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.belongs_to :user, index: true
      t.belongs_to :skill, index: true
      t.date :start_date
      t.text :description
      t.integer :level
    end
  end
end
