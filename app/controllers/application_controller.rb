class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_headers

  def after_sign_out_path_for(resources)
    if resource_class == Participant
      "/display/#{params["secure_key"]}"
    else
      new_admin_user_session_path
    end
  end
  
  def download_pdf
  send_file(
    "#{Rails.root}/public/SweepstakePromotionBestPractices.pdf",
    filename: "SweepstakePromotionBestPractices.pdf",
    type: "application/pdf"
  )
end
  def after_sign_in_path_for(resources)
    if request.env["omniauth.auth"].present?
      "/display/#{request.env["omniauth.params"]["secure_key"]}"
    elsif resource_class == AdminUser
      dashboards_path
    elsif resource_class == Participant
      "/display/#{resources.secure_key}"
    end
  end
  
  protected
  
  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
  
  def configure_permitted_parameters
    if resource_class == AdminUser
      devise_parameter_sanitizer.for(:sign_up).push(:name, :mobile_number, :avatar)
    else
      devise_parameter_sanitizer.for(:sign_up).push(:participant_name, :participant_number, :answer, :entry_option_id, :secure_key, :admin_user_id, :sweepstake_id)
    end
  end
  
  def is_superadmin?
    current_admin_user.is_superadmin
  end
  
end
