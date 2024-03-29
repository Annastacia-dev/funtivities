class EventsHostMailerPreview < ActionMailer::Preview
  def confirmation_email
    host = EventsHost.first
    EventsHostMailer.with(events_host: host).confirmation_email
  end
end