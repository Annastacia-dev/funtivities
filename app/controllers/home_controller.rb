class HomeController < ApplicationController

  before_action :get_user_location

  def index
  end

  private

  def get_user_location
    @user_location = request.location
  end
end