class WelcomeController < ApplicationController
  def search
    @skills = Skill.all
  end
  
  def results
    begin
      @users = Experience.find_by(skill: params[:skill_id]).skill.users.near("#{params[:city]}, #{params[:state]}", params[:radius])
    rescue NoMethodError
      @skills = Skill.all
      render 'search', notice: "No results"
    end
  end
  
  private
  
  def search_params
    params.permit(:skill_id, :city, :state, :radius)
  end
  
end
