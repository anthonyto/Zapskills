class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:main, :about, :contact, :help, :termsandconditions, :howto]
  
  def search
    @skills = Skill.all
  end
  
  def results
    if search_params[:around_me] == "1"
      @users = User.near(current_user, search_params[:radius]).where.not(id: current_user.id)
    else
      begin
        if search_params[:skill_id] == ""
          @users = User.near("#{search_params[:city]}, #{search_params[:state]}", search_params[:radius]).where.not(id: current_user.id)
        else
          @users = Experience.find_by(skill: search_params[:skill_id]).skill.users.near("#{search_params[:city]}, #{search_params[:state]}", search_params[:radius]).where.not(id: current_user.id) 
        end
      rescue NoMethodError
        @skills = Skill.all
        redirect_to search_path, notice: "No results"
      end
    end
    if @users.empty?
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
    params.permit(:skill_id, :city, :state, :radius, :around_me)
  end
  
end
