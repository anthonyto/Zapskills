class RemoveAppointmentIdFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :appointment_id, :integer
  end
end
