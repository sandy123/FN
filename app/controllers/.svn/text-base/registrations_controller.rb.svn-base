class RegistrationsController < Devise::RegistrationsController
  
  def create
    super
  end  
  
  protected

  def after_sign_up_path_for(resource)
    flash[:notice] = "Please check your email and click on the activation link in the email. "
  end
  
  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = "Please check your email and click on the activation link in the email. "
  end
end