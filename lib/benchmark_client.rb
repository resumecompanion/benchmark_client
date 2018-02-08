require "benchmark_client/version"
require 'benchmark_client/base'
require 'benchmark_client/configuration'

module BenchmarkClient
  class << self
    attr_accessor :configuration
  end
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
