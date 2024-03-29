# == Schema Information
#
# Table name: events_hosts
#
#  id          :uuid             not null, primary key
#  description :text
#  email       :string
#  name        :string
#  phone       :string
#  slug        :string
#  status      :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class EventsHost < ApplicationRecord
  has_paper_trail

  # --- concerns ---
  include Sluggable

  # --- friendly_id ---
  friendly_slug_scope to_slug: :name

  # --- active storage attachments ---
  has_one_attached :logo
  has_one_attached :cover_image

  # --- associations ---
  has_many :events, dependent: :destroy
  has_one :location, as: :locatable, dependent: :destroy

end
