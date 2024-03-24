class HomeController < ApplicationController

  before_action :get_user_location

  def index
  end

  private

  def get_user_location
    @user_location = request.location
    @events = Event.near([@user_location.latitude, @user_location.longitude], 50)
  end
end