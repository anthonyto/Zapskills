class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :verify_complete_profile, only: [:show]
    
  def index
    @users = User.all
  end

  def show
  end

  def edit
    if !authorize_user(@user)
      redirect_to errors_401_path and return
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
  
  def authorize_user(user)
    user == current_user
  end

  # Use callbacks to share common setup or constraints between actions.
   def set_user
     @user = User.find(params[:id])
   end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :zip_code, :password, :profile_picture_url, :avatar)
  end
end
