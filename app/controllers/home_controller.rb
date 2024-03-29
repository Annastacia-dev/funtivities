class HomeController < ApplicationController

  before_action :get_user_location

  def index
  end

  def manifest
    render file: "#{Rails.root}/manifest.json", content_type: 'application/json'
  end

  private

  def get_user_location
    @user_location = request.location
    @events = Event.all
  end
end