module BenchmarkClient
  class BenchmarkError < StandardError ; end
  class Base
    def self.update(*args)
      new.update(*args)
    end

    def initialize(*args)
      setup_remote_server
    end

    def update(list_id, contacts_array)
      result = batchAddContacts(list_id, contacts_array)

      if status
        true
      else
        raise BenchmarkError.new("Error Code: #{result.faultCode} Error Description #{result.faultString}")
      end
    end

    def method_missing(api_method, *args)
      self.status, result = server.call2(api_method.to_s, @token, *args)

      result
    end

    private

    attr_accessor :status, :server

    def setup_remote_server
      self.server = XMLRPC::Client.new2(BenchmarkError.configuration.api_url)
      self.status, result = server.call2('login', Benchmark.configuration.username, Benchmark.configuration.password)

      if status
        @token = result
      else
        puts "Error Code: #{result.faultCode}"
        puts "Error Description: #{result.faultString}"
      end
    end
  end
end
