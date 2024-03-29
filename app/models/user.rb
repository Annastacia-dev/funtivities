# == Schema Information
#
# Table name: users
#
#  id                                      :uuid             not null, primary key
#  confirmation_sent_at                    :datetime
#  confirmation_token                      :string
#  confirmed_at                            :datetime
#  current_sign_in_at                      :datetime
#  current_sign_in_ip                      :string
#  email                                   :string           default(""), not null
#  encrypted_password                      :string           default(""), not null
#  failed_attempts                         :integer          default(0), not null
#  first_name                              :string           not null
#  last_name                               :string           not null
#  last_sign_in_at                         :datetime
#  last_sign_in_ip                         :string
#  locked_at                               :datetime
#  middle_name                             :string
#  phone_number                            :string           not null
#  remember_created_at                     :datetime
#  reset_password_sent_at                  :datetime
#  reset_password_token                    :string
#  role                                    :integer          default(0)
#  sign_in_count                           :integer          default(0), not null
#  status                                  :integer          default(0)
#  terms_and_conditions_and_privacy_policy :boolean          default(FALSE)
#  unconfirmed_email                       :string
#  unlock_token                            :string
#  created_at                              :datetime         not null
#  updated_at                              :datetime         not null
#  events_host_id                          :uuid
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_events_host_id        (events_host_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (events_host_id => events_hosts.id)
#
class User < ApplicationRecord
  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  # --- associations ----
  belongs_to :events_host, optional: true

  # --- validations ----
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, uniqueness: true
  validates :terms_and_conditions_and_privacy_policy, acceptance: true
  validate :one_account_admin_per_events_host
  validate :one_superadmin

  # --- enums ----
  enum role: { user: 0, account_admin: 1, superadmin: 2 }

  # --- callbacks ----
  before_save :downcase_email
  before_save :downcase_name
  before_save :skip_confirmation_if_admin

  # --- instance methods ----
  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    account_admin? || superadmin?
  end

  def superadmin?
    role == 'superadmin'
  end

  def account_admin?
    role == 'account_admin'
  end

  # --- class methods ----

  # --- private methods ----
  private

  def downcase_email
    self.email = email.downcase
  end

  def downcase_name
    self.first_name = first_name.downcase
    self.last_name = last_name.downcase
    self.middle_name = middle_name.downcase if middle_name.present?
  end

  def skip_confirmation_if_admin
    return unless admin?

    self.skip_confirmation!
    self.skip_confirmation_notification!
    self.confirmed_at = Time.zone.now
  end

  def one_account_admin_per_events_host
    return unless account_admin?

    errors.add(:role, 'cannot have more than one account admin per events host') if events_host.present? && events_host.users.where(role: 'account_admin').exists?
  end

  def one_superadmin
    return unless superadmin?

    errors.add(:role, 'cannot have more than one superadmin') if User.where(role: 'superadmin').exists?
  end

end
