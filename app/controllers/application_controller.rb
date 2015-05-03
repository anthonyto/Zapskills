class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  def verify_complete_profile
    unless (current_user.first_name != nil &&
            current_user.last_name != nil &&
            current_user.city != nil &&
            current_user.state != nil &&
            current_user.zip_code != nil)
      redirect_to edit_user_path(current_user), notice: 'Please complete your profile before proceeding.' and return
    end
  end
  
end
