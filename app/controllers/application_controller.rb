class ApplicationController < ActionController::Base
  before_action :set_background_image
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit
  before_action :set_events_host

  private

  def set_events_host
    @host = current_user&.events_host
  end

  def set_background_image
    @background_image = "https://res.cloudinary.com/dlahz5ciz/image/upload/v1711697213/cover_cxttwh.jpg"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name middle_name last_name phone_number events_host_id role terms_and_conditions_and_privacy_policy])
  end

end
