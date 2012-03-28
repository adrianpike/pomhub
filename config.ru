# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

Pomhub::Application.use Rack::Auth::Basic do |username, password|
   password == ENV['STAGING_PASSWORD']
end

run Pomhub::Application
