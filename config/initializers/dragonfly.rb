require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "2bb5e27aa9564eab6eb1bcb9d73aa1f7b17e16303fc50212d0fa360a533550d7"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
