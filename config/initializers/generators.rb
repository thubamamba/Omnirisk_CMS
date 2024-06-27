Rails.application.config.generators do |g|
  # g.orm :active_record, primary_key_type: :uuid
  g.orm :active_record, primary_key_type: :bigint
  # Dont generate app/assets/controller_name.scss with generators
  g.stylesheets false
  g.helper false
  g.jbuilder false
end
