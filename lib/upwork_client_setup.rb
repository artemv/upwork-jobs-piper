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

    if !config.access_token and !config.access_secret
      fail 'You need to get the API keys at Upwork app center'
    end

    # setup client
    client = Upwork::Api::Client.new(config)

    client
  end

end
