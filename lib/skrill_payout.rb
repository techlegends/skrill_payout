module SkrillPayout

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end

# VERSION
require 'skrill_payouts/version'

# GEM CLASS
require 'skrill_payout/skrill_api'
require 'skrill_payout/skrill_payout'
require 'skrill_payout/prepare_transfer'
require 'skrill_payout/execute_transfer'
require 'skrill_payout/skrill_payout_exception'
require 'skrill_payout/configuration'

# GEMS
require 'faraday'
require 'xmlsimple'
