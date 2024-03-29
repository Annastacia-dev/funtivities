# == Schema Information
#
# Table name: events
#
#  id             :uuid             not null, primary key
#  description    :text
#  end_date       :datetime
#  event_category :integer          default("arts & crafts")
#  event_status   :integer          default("active")
#  slug           :string
#  start_date     :datetime
#  status         :integer          default("draft")
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  events_host_id :uuid             not null
#
# Indexes
#
#  index_events_on_events_host_id  (events_host_id)
#
# Foreign Keys
#
#  fk_rails_...  (events_host_id => events_hosts.id)
#
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
