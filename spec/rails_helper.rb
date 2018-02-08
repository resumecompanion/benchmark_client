require 'bundler/setup'

Bundler.setup

require 'benchmark_client'
require 'rspec'
require 'pry'
require 'vcr'
require 'webmock/rspec'

BenchmarkClient.configure do |config|
  config.username = 'alan.yu@tarokosoftware.com'
  config.password = 'yefAO1ntGzlxcV@jqy^J'
  config.api_url = 'http://api.benchmarkemail.com/1.3/'
  config.default_list_name = 'test'
end


RSpec.configure do |config|
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
end
