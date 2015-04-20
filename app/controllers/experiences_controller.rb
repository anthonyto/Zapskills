class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy]

  def index
    @experiences = Experience.all
  end

  def show
  end

  def new
    @experience = Experience.new
    # @skills = Skill.all.map { |skill| [skill.name] }
    @skills = Skill.all
  end

  def edit
  end

  def create
    # skill = Skill.find_by(:name => params[:skill])
    # experience_params[:skill_id] = skill_id
    @experience = Experience.new(experience_params)
    @experience.update_attributes(user: current_user)
    if @experience.save
      redirect_to current_user
    else
      render :new
    end
  end

  def update
    if @experience.update(experience_params)
      redirect_to @experience, notice: 'Experience was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @experience.destroy
    redirect_to experiences_url, notice: 'Experience was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:description, :start_date, :level, :user_id, :skill_id)
    end
end