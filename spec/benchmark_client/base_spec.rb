require 'rails_helper'

describe BenchmarkClient::Base do
  describe '.update', vcr: true do
    let(:contacts) do
      [
        {:email => 'user1@mail.com', :firstname => 'PeterChangeName', :lastname => 'Parker', custom_field: 1, custom_field2: 2 },
        {:email => 'user2@mail.com', :firstname => 'Bruce', :lastname => 'Banner'}
      ]
    end

    context 'update contacts in a exist contact list', vcr: true do
      it 'update the data correctly' do
        client = described_class.new
        list_id = client.listCreate(BenchmarkClient.configuration.default_list_name)
        client.listGet(list_id)

        expect(client.update(list_id, contacts)).to eql true
      end
    end

    context 'update contacts in an inexist contact list', vcr: true do
      let(:contacts) { [] }
      it 'raise BenchmarkError' do
        BenchmarkClient.configure do |config|
          config.username = 'error'
          config.password = 'error'
        end

        expect { described_class.update('asdfhsadf', contacts) }.to raise_error(BenchmarkClient::BenchmarkError)
      end
    end
  end

  describe '.create_list', vcr: true do
    it 'call list correctly' do
      list_name = 'test'
      BenchmarkClient.configure do |config|
        config.default_list_name = list_name
      end

      client = described_class.new
      expect(client.create_list).to eql '15472311'
    end
  end
end
