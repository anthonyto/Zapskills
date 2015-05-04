class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:edit, :update, :destroy]
  before_action :set_skills
  
  def new
    @experience = Experience.new
  end
  
  def create
    unless current_user.experiences.find_by(skill_id: experience_params[:skill_id]).nil? 
      flash[:notice] = "Sorry, you already have that skill."
      redirect_to new_user_experience_path(current_user) and return
    end
    @experience = Experience.new(experience_params)
    @experience.assign_attributes(user: current_user)
    if @experience.save
      redirect_to current_user
    else
      render :new
    end
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
    params.require(:experience).permit(:description, :level, :user_id, :skill_id)
  end
end
