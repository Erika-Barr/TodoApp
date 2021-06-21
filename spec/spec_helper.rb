require "selenium/webdriver"
require 'capybara/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  Capybara.server = :puma, { Silent: true }
  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'disable-gpu'])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
  Capybara.default_driver = :headless_chrome
end
