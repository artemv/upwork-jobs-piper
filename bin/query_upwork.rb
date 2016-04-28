#!/Users/artem/.rvm/rubies/ruby-2.2.2/bin/ruby
require "dotenv"
require_relative '../lib/upwork_client_setup'
require 'upwork/api/routers/jobs/profile'
require 'upwork/api/routers/freelancers/profile'

Dotenv.load

client = UpworkClientSetup.setup_client
result = nil
if ENV['JOB_ID']
  profile = Upwork::Api::Routers::Jobs::Profile.new(client)
  result = profile.get_specific(ENV['JOB_ID'])
elsif ENV['FREELANCER_ID']
    profile = Upwork::Api::Routers::Freelancers::Profile.new(client)
    result = profile.get_specific(ENV['FREELANCER_ID'])
else
  variants = []
  indent = "  "
  variants << 'JOB_ID="_~01a9a3a697ce5e4cf5" ruby bin/query_upwork.rb'
  variants << 'FREELANCER_ID="~01af205f17cc6d5f2d" ruby bin/query_upwork.rb'
  puts "Usage:\n#{indent}" + variants.join("\nOR\n#{indent}")
end

fail unless result
puts JSON.pretty_generate(result)
