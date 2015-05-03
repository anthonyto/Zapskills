class RemoveStartDateFromExperiences < ActiveRecord::Migration
  def change
    remove_column :experiences, :start_date, :date
  end
end
