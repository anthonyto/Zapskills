class AddRatingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rating, :double
  end
end
