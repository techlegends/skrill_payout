require 'bundler/setup'
Bundler.setup

require 'skrill_payout'
require 'webmock/rspec'

RSpec.configure do |config|
end

# SUPPORT FILES
require File.expand_path('../support/config.rb', __FILE__)
require File.expand_path('../support/payout.rb', __FILE__)

WebMock.disable_net_connect!(allow_localhost: true)

