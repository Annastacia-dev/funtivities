class EventsController < ApplicationController

  before_action :find_events_host

  def index
    @events = Event.all
  end

  def new
    @event = @events_host.events.new
  end

  def create
    @event = @events_host.events.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event created successfully' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_events_host
    @events_host = current_user&.events_host
  end

  def events_params
    params.require(:event).permit(:title, :category, :cover_image, :start_date, :end_date, :description)
  end

end