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

    if !config.access_token and !config.consumer_key
      puts 'Initialize .env file first'
      return nil
    end

    # setup client
    client = Upwork::Api::Client.new(config)

    if !config.access_token and !config.access_secret
      authz_url = client.get_authorization_url

      puts 'Visit the authorization url and enter the oauth_verifier code from that page here:'
      puts authz_url
      verifier = gets.strip
      client.get_access_token(verifier)
      puts 'Put these access token keys into .env file:'
      info = {'UPWORK_ACCESS_TOKEN' => config.access_token, 'UPWORK_ACCESS_SECRET' => config.access_secret}
      puts info.inspect
      return nil
    end

    client
  end

end
