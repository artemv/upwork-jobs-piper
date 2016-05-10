# frozen_string_literal: true
RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:example) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:example, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:example) do
    DatabaseCleaner.start
  end

  config.after(:example) do
    DatabaseCleaner.clean
  end
end
