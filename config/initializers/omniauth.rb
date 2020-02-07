Rails.application.config.middleware.use OmniAuth::Builder do
  # is google_oauth2 being used?
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], scope: "user,reop"
end
