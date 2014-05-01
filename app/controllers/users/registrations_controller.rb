class Users::RegistrationsController < Devise::RegistrationsController
  layout "authorization"
  
  def update
    @user = current_user
    successfully_updated = if @user.needs_password?
      @user.update_with_password(account_params)
    else
      params[:user].delete(:current_password)
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      params[:user].delete(:email)
      @user.update_without_password(account_params)
    end
    
    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end
  
  private
  
  def after_update_path_for(resource)
    user_path(resource)
  end
  
  def account_params
    params.require(:user).permit(:username, :password, :password_confirmation,
                                 :current_password, :avatar, :avatar_cache)
  end
end
