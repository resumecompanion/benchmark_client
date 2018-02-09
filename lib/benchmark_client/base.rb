require 'xmlrpc/client'

module BenchmarkClient
  class BenchmarkError < StandardError ; end
  class Base
    def self.update(*args)
      new.update(*args)
    end

    def self.create_list(list_name = nil)
      new.create_list(list_name)
    end

    def initialize
      setup_remote_server
    end

    def update(list_id, contacts_array)
      list_id ||= get_list

      result = batchAddContacts(list_id, contacts_array)

      if status
        true
      else
        raise_error(result)
      end
    end

    def create_list(list_name = BenchmarkClient.configuration.default_list_name)
      listCreate(list_name)
    end

    def get_list(list_name = BenchmarkClient.configuration.default_list_name)
      BenchmarkClient.configuration.list_id ||= begin
                                                  listGet(list_name, 1, 100, '', '').first['id']
                                                end
    end

    def method_missing(api_method, *args)
      self.status, result = server.call2(api_method.to_s, @token, *args)

      result
    end

    private

    attr_accessor :status, :server

    def setup_remote_server
      self.server = XMLRPC::Client.new2(BenchmarkClient.configuration.api_url)
      self.status, result = server.call2('login', BenchmarkClient.configuration.username, BenchmarkClient.configuration.password)

      if status
        @token = result
      else
        raise_error(result)
      end
    end

    def raise_error(result)
      raise BenchmarkError, "Error Code: #{result.faultCode} Error Description #{result.faultString}"
    end
  end
end
