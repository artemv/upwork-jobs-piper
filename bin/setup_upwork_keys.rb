#!/Users/artem/.rvm/rubies/ruby-2.2.2/bin/ruby
require "dotenv"
require_relative '../lib/upwork_client_setup'

Dotenv.load

if UpworkClientSetup.setup_client
  puts "Upwork client access is set up already"
end
