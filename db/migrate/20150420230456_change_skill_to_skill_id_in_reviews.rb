class ChangeSkillToSkillIdInReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :skill, :string
    add_column :reviews, :skill_id, :integer
  end
end
