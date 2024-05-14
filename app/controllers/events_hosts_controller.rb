class EventsHostsController < ApplicationController
  before_action :set_events_host, only: [:show, :edit, :update, :destroy, :create_admin_user]

  def index
  end

  def show
  end

  def new
    @events_host = EventsHost.new
  end

  def edit
  end

  def create
    @events_host = EventsHost.new(events_host_params)

    respond_to do |format|
      if @events_host.save
        send_confirmation_email(@events_host)
        format.html { redirect_to confirmation_message_events_host_path(@events_host) }
        format.json { render :show, status: :created, location: @events_host }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @events_host.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_confirmation_email(events_host)
    EventsHostMailer.with(events_host: events_host).confirmation_email.deliver_now
  end

  def confirm
    if params[:token].present?
      @events_host = EventsHost.find_by(confirmation_token: params[:token])
      if @events_host.present?
        @events_host.update(confirmation_token: nil, confirmed_at: Time.now, confirmed: true)
        redirect_to create_admin_user_events_host_path(@events_host), notice: "Your account has been confirmed."
      else
        redirect_to root_path, alert: "Invalid confirmation token."
      end
    else
      redirect_to root_path, alert: "Invalid confirmation token."
    end
  end

  def create_admin_user
    @resource = User.new
  end

  def update
    respond_to do |format|
      if @events_host.update(events_host_params)
        format.html { redirect_to @events_host, notice: 'Events host was successfully updated.' }
        format.json { render :show, status: :ok, location: @events_host }
      else
        format.html { render :edit }
        format.json { render json: @events_host.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @events_host.destroy
    respond_to do |format|
      format.html { redirect_to events_hosts_url, notice: 'Events host was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_events_host
    @events_host = EventsHost.friendly.find(params[:id])
  end

  def events_host_params
    params.require(:events_host).permit(:name, :email, :phone, :logo, :description)
  end

end