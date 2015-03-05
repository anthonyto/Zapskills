class RenameDescriptionToBodyInMessages < ActiveRecord::Migration
  def change
    rename_column :reviews, :description, :body
  end
end
