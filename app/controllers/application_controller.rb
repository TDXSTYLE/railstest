class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception

before_action :configure_permitted_parameters, if: :devise_controller?


helper_method :current_user_subscribed?


 def current_user_subscribed?
   user_signed_in? && current_user.subscribed?
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


end
