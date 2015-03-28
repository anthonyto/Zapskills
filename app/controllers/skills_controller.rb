class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  def index
    @skills = current_user.skills
  end

  def show
  end

  def new
    @skill = current_user.experiences.build
    # @skill = Skill.experiences.new(current_user)
  end

  def edit
  end

  def create
    @skill = current_user.experiences.build(skill_params)
    # @skill = Skill.experiences.new(current_userskill_params)
    if @skill.save
      redirect_to current_user, notice: 'Skill was successfully created.'
    else
      render :new
    end
  end

  def update
    if @skill.update(skill_params)
      redirect_to @skill, notice: 'Skill was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @skill.destroy
    redirect_to skills_url, notice: 'Skill was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:name)
    end
end
