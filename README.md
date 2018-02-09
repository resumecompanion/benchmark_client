# BenchmarkClient

Benchmark ruby client which wraper the sameple the benchmark provide [here](https://apidocs.benchmarkemail.com/#/download-wrappers)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'benchmark_client', git: 'git@github.com:resumecompanion/benchmark_client.git'

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install benchmark_client

## Usage

### Config the credential 

```ruby

    # in initializer/benchmark_client.rb
    
    BenchmarkClient.configure do |config| 
      config.username = 'your_user_name'
      config.password = 'password'
      config.api_url = 'url_of_api_version'
      config.default_list_name = 'the list name you will create in benchmark'
    end

```


### Create list 

When sync user's data to benchmark, you need to create a list name first


    ```
    list_id = BenchmarkClient::Base.create_list # 

    ```

### Update Contacts into list 

    ```
    list_id = BenchmarkClient::Base.get_list

    contacts = [
    {:email => 'user1@mail.com', :firstname => 'PeterChangeName', :lastname => 'Parker', custom_field: 1, custom_field2: 2},
    {:email => 'user2@mail.com', :firstname => 'Bruce', :lastname => 'Banner'}
     ]


    BenchmarkClient.update(list_id, contacts)
    ```

### Custom Fields in Benchmark contacts

For the custom field in the contacts, you need to go to `Benchmark -> Contacts -> Edit the contact field`

to add new field you will update.



### Benchmark api documentation 

[doc](https://apidocs.benchmarkemail.com/#/library)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

