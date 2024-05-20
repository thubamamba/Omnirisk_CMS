class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include Accounts::SubscriptionStatus
  include ActiveStorage::SetCurrent
  include Authentication
  include Authorization
  include CurrentHelper
  include DeviceFormat
  include Pagy::Backend
  include SetCurrentRequestDetails
  include SetLocale
  include Sortable
  include Users::AgreementUpdates
  include Users::NavbarNotifications
  include Users::Sudo
  include Users::TimeZone
end
