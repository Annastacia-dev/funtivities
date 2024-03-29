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
class Location < ApplicationRecord
  has_paper_trail

  # --- concerns ---
  include Sluggable

  # --- friendly_id ---
  friendly_slug_scope to_slug: :address

  # --- callbacks ---
  after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

  # --- associations ---
  belongs_to :locatable, polymorphic: true
  geocoded_by :address

  # --- validations ---
  validates :city, presence: true
  validates :country, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :status, presence: true

  # --- enums ---
  enum status: {
    inactive: 0,
    active: 1
  }

  def address
    "#{street}, #{city}, #{state}, #{country}"
  end


end
