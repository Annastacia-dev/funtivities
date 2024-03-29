# == Schema Information
#
# Table name: locations
#
#  id               :uuid             not null, primary key
#  building_name    :string
#  city             :string           not null
#  country          :string           not null
#  county           :string
#  extra_info       :text
#  floor_number     :string
#  latitude         :decimal(10, 6)
#  locatable_type   :string           not null
#  longitude        :decimal(10, 6)
#  nearest_landmark :string
#  postal_code      :string
#  room_number      :string
#  slug             :string
#  state            :string
#  status           :integer          default("inactive")
#  street           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  locatable_id     :bigint           not null
#
# Indexes
#
#  index_locations_on_locatable  (locatable_type,locatable_id)
#
require "test_helper"

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
