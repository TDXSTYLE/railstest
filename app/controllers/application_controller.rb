class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception

before_action :configure_permitted_parameters, if: :devise_controller?


helper_method :current_user_subscribed?


helper_method :current_user_admin?


before_action :get_config_nerd

 def current_user_subscribed?
   user_signed_in? && current_user.subscribed?
 end

 def current_user_admin?
     user_signed_in? && current_user.admin
   end


 protected

def configure_permitted_parameters
  # devise_parameter_sanitizer.for(:sign_up) << :name
  # devise_parameter_sanitizer.for(:account_update) << :name
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name])
end



def subscription_required
  redirect_to new_subscription_path, notice: "You must subscribe to view that page. Subscribe below." unless current_user_subscribed?
end


def admin_required
    redirect_back(fallback_location: root_path, notice: "You can not view this page.") unless current_user_admin?
  end



  def get_config_nerd
    @config_nerd = ConfigNerd.first_or_create do |confignerd|
     confignerd.video_ad_id = ""
   end
 end



end
