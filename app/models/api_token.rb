class ApiToken < ApplicationRecord
  DEFAULT_NAME = I18n.t("api_tokens.default")
  APP_NAME = I18n.t("api_tokens.app")

  has_prefix_id :token
  has_secure_token :token

  belongs_to :user

  scope :sorted, -> { order("last_used_at DESC NULLS LAST, created_at DESC") }

  validates :name, presence: true

  def can?(permission)
    Array.wrap(data("permissions")).include?(permission)
  end

  def cant?(permission)
    !can?(permission)
  end

  def data(key, default: nil)
    (metadata || {}).fetch(key, default)
  end

  def expired?
    expires_at? && Time.current >= expires_at
  end

  def touch_last_used_at
    return if transient?
    update(last_used_at: Time.current)
  end

  def generate_token
    loop do
      self.token = SecureRandom.hex(16)
      break unless ApiToken.where(token: token).exists?
    end
  end
end
