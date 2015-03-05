class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :city
      t.string :state
      t.string :zip_code
      t.date :date_of_birth
      t.string :password
      t.string :profile_picture_url

      t.timestamps null: false
    end
  end
end
