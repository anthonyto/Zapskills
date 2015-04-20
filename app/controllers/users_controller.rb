class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
  end

  # There needs to be authorization here about what user can see what profile and how those profiles look
  def show
    @user = User.find(params[:id])
    if !current_user.complete_profile?
      render 'edit', notice: 'Please complete your profile.'
    end
  end

  def new
    @user = User.new
  end

  def edit
    if !authorize_user(@user)
      render 'errors/401'
      return
    end
  end

  def create
    @user = User.new(user_params)    
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # Do we need this?
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
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :zip_code, :date_of_birth, :password, :profile_picture_url)
    end
end
