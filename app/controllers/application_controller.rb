class ApplicationController < ActionController::Base
  before_action :set_background_image

  private

  def set_background_image
    @background_image = "https://res.cloudinary.com/dlahz5ciz/image/upload/v1711697213/cover_cxttwh.jpg"
  end

end
