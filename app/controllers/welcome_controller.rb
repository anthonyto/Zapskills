class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:main, :about, :contact, :help, :termsandconditions, :howto]
  before_action :verify_complete_profile, only: [:search, :results]
  
  def search
    @skills = Skill.all
  end
  
  def results
    # if the user isn't searching "around_me", then set a location based on their parameters
    # otherwise, use the current_user's location
    if search_params[:around_me] == "1"
      location = "#{current_user.latitude}, #{current_user.longitude}"
    else
      location = "#{search_params[:city]}, #{search_params[:state]}"
    end
    # if a skill_id isn't included, just search all users around the location
    # otherwise, look for all skills of skill_id around the location 
    begin
      if search_params[:skill_id] == ""
        # Find all users that have experiences, around the location of a given radius, that is not the user themselves
        @users = User.includes(:experiences).where.not( experiences: { id: nil } ).near(location, search_params[:radius]).where.not(id: current_user.id)
      else
        # Find all experiences of a given skill, then the users that own those experiences, around the location of a given radius, that is not the users themselves
        @users = Experience.find_by(skill: search_params[:skill_id]).skill.users.near(location, search_params[:radius]).where.not(id: current_user.id) 
      end
    rescue NoMethodError
      @skills = Skill.all
      redirect_to search_path, notice: "No results" and return
    end
    if @users.nil?
      @skills = Skill.all
      redirect_to search_path, notice: "No results"
    end
  end
  
  def about
  end
  
  def contact
  end
  
  def help
  end
  
  def howto
  end
  
  def termsandconditions
  end
  
  def main
    render layout: false
  end
  
  
  private
  
  def search_params
    params.permit(:skill_id, :city, :state, :radius, :around_me)
  end
  
end
