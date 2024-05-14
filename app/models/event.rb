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
class Event < ApplicationRecord
  has_paper_trail

  # --- concerns ---
  include Sluggable

  # --- friendly_id ---
  friendly_slug_scope to_slug: :title

  # --- active storage attachments ---
  has_one_attached :cover_image

  # --- associations ---
  belongs_to :events_host
  has_one :location, as: :locatable, dependent: :destroy

  # --- validations ---
  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  # --- enums ---
  enum status: {
    draft: 0,
    published: 1,
    archived: 2
  }

  enum event_category: {
    'arts & crafts': 0,
    'food & drinks': 1,
    'music & dance': 2,
    'sports & fitness': 3,
    'tech & science': 4,
    'health & wellness': 5,
    'community & culture': 6
  }

  enum event_status: {
    'active': 0,
    'cancelled': 1,
    'postponed': 2
  }

  # --- scopes ---


  # --- class methods ---


  # --- instance methods ---
  def self.event_categories_options
    event_categories.map { |k, _v| [k.humanize, k] }
  end

  # --- private methods ---

end
