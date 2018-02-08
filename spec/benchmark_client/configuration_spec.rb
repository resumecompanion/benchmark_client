require 'rails_helper'

module BenchmarkClient
  describe Configuration do
    before :all do
      BenchmarkClient.configure do |config|
        config.username = 'user'
        config.password = 'password'
        config.api_url = 'api_url'
      end
    end

    describe '#username' do
      it 'set username by configuration' do
        expect(BenchmarkClient.configuration.username).to eql 'user'
      end
    end

    describe '#password' do
      it 'set password' do
        expect(BenchmarkClient.configuration.password).to eql 'password'
      end
    end

    describe '#api_url' do
      it 'set api url' do
        expect(BenchmarkClient.configuration.api_url).to eql 'api_url'
      end
    end
  end
end
