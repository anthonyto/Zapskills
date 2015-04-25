class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:edit, :update, :destroy]
  before_action :set_skills
  
  def new
    @experience = Experience.new
  end
  
  def create
    #puts "controller start"
    #current_user.skills.find_each do |sk|
    #  puts sk.name
    #end
    #puts "controller end"
    @experience = Experience.new(experience_params)
    #puts "controller start"
    #current_user.skills.find_each do |sk|
    #  puts sk.name
    #end
    #puts "controller end"
    @experience.assign_attributes(user: current_user)
    #puts "controller start"
    #puts @experience.skill_id
    #current_user.skills.find_each do |sk|
    #  puts sk.name
    #end
    #puts "controller end"
    if @experience.save!
      redirect_to current_user
    else
      render :new
    end
    #puts "controller start"
    #current_user.skills.find_each do |sk|
    #  puts sk.name
    #end
  end

  def edit
  end

  def update
    if @experience.update(experience_params)
      redirect_to current_user, notice: 'Skill was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @experience.destroy
    redirect_to current_user, notice: 'Skill was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.find(params[:id])
    end
    
    def set_skills
      @skills = Skill.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:description, :start_date, :level, :user_id, :skill_id)
    end
end
