class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :appointment
      t.string :skill
      t.integer :stars
      t.text :description

      t.timestamps null: false
    end
  end
end
