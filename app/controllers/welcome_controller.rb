class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:main, :about, :contact, :help, :termsandconditions, :howto]
  
  def search
    @skills = Skill.all
  end
  
  def results
    begin
      if params[:skill_id] == ""
        @users = Experience.all.users.near("#{params[:city]}, #{params[:state]}", params[:radius]).where.not(id: current_user.id)
      else
        @users = Experience.find_by(skill: params[:skill_id]).skill.users.near("#{params[:city]}, #{params[:state]}", params[:radius]).where.not(id: current_user.id) 
      end
    rescue NoMethodError
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
  end
  
  
  private
  
  def search_params
    params.permit(:skill_id, :city, :state, :radius)
  end
  
end
