class EventsHostMailer < ApplicationMailer
  def confirmation_email
    @host = params[:events_host]
    subject = 'Welcome to funtivities - Confirm your account'
    mail(
      to: @host&.email,
      subject: subject
    )
  end
end