class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :tutor
      t.references :tutee
      t.datetime :date_and_time
      t.string :status
      t.string :skill

      t.timestamps null: false
    end
  end
end
