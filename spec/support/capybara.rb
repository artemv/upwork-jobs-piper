# frozen_string_literal: true
require 'capybara/poltergeist'
# require 'capybara/webkit'

# Capybara.javascript_driver = :webkit
Capybara.asset_host = 'http://localhost:3017'
Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 5
