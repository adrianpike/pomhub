Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, ENV['GH_KEY'], ENV['GH_SECRET'], :scope => 'repo'
end