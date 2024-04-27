class Account::AcceptedInviteNotifier < ApplicationNotifier
  deliver_by :action_cable do |config|
    config.channel = "Noticed::NotificationChannel"
    config.stream = -> { recipient }
    config.message = :to_websocket
  end

  def user
    record || params[:user] || User.new(name: "Someone")
  end

  def message
    t "notifications.invite_accepted", user: user.name
  end

  def url
    account_path(account)
  end
end
