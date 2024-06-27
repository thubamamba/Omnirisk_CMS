class User < ApplicationRecord
  has_prefix_id :user

  include Accounts
  include Agreements
  include Authenticatable
  include Mentions
  include Notifiable
  include Searchable
  include Theme

  has_one_attached :avatar
  has_person_name
  # has_many :audits, as: :auditable
  audited

  validates :avatar, resizable_image: true
  validates :name, presence: true

  scope :internal_users, -> { where("email LIKE ?", "%@entresure.co.za") }

  ADMIN_ROLES = [:super_admin, :insurance_officer]
end
