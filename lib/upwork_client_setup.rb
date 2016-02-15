require 'upwork/api'
require 'upwork/api/routers/auth'
require 'upwork/api/routers/mc'
require 'upwork/api/routers/reports/time'
require 'upwork/api/routers/freelancers/search'
require 'upwork/api/routers/jobs/profile'

class UpworkClientSetup

  def self.setup_client
    # initiate config
    config = Upwork::Api::Config.new({
                                       'consumer_key'    => ENV['UPWORK_CONSUMER_KEY'],
                                       'consumer_secret' => ENV['UPWORK_CONSUMER_SECRET'],
                                       'access_token'    => ENV['UPWORK_ACCESS_TOKEN'], # assign if known
                                       'access_secret'   => ENV['UPWORK_ACCESS_SECRET'], # assign if known
                                       'debug'           => false
                                     })

    # setup client
    client = Upwork::Api::Client.new(config)

    # run authorization in case we haven't done it yet
    # and do not have an access token-secret pair
    if !config.access_token and !config.access_secret
      authz_url = client.get_authorization_url

      puts 'Visit the authorization url and provide oauth_verifier for further authorization'
      puts authz_url
      fail
      verifier = gets.strip
      @token = client.get_access_token(verifier)
      p [config.access_token, config.access_secret]
      # store access token data in safe place!
    end

    client
  end

end
