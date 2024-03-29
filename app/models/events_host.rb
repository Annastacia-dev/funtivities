# == Schema Information
#
# Table name: events_hosts
#
#  id                 :uuid             not null, primary key
#  confirmation_token :string
#  confirmed          :boolean          default(FALSE)
#  confirmed_at       :datetime
#  description        :text
#  email              :string
#  name               :string
#  phone              :string
#  slug               :string
#  status             :integer          default("pending")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
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

  # --- enums ---
  enum status: { pending: 0, active: 1, inactive: 2 }

  # --- validations ---
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A[0-9]{10}\z/ }
  validates :description, presence: true
  validate :logo_attached

  # --- callbacks ---
  before_save :downcase_email
  before_save :downcase_name
  before_create :generate_confirmation_token

  # --- scopes ---

  # --- instance methods ---

  # --- class methods ---

  private

  def downcase_email
    email.downcase!
  end

  def downcase_name
    name.downcase!
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64.to_s
  end

  def logo_attached
    errors.add(:logo, 'must be attached') unless logo.attached?
  end

end
