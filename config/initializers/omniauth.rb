Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET, :scope => 'email,user_birthday,read_stream', :display => 'popup'
end

#if Rails.env == "production"
# no production app yet
#else
#  if ENV['USER'] == 'monica'
#    Rails.application.config.middleware.use OmniAuth::Builder do
#      #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
#      provider :facebook, '414916455235699', 'cea526b14ef60552c80071669430fafe'  # Find these values on the Facebook App page
#    end
#  end
#end