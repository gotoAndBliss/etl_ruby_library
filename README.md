# EtlRubyWrapper

EtlRubyWrapper is a Ruby gem that facilitates Extract, Transform, Load (ETL) operations by running a Go binary within a Ruby environment. It’s designed for projects that need efficient data processing using Go, with the convenience of orchestrating and handling processes in Ruby. This gem is especially useful for data migration tasks or integrating external data into your application.

## Installation
Add the gem to your application's Gemfile by executing:

```bash
Copy code
$ bundle add etl_ruby_wrapper
```

Or, if Bundler isn’t being used, install the gem directly:

```bash
Copy code
$ gem install etl_ruby_wrapper
```

## Usage
Here's an example of how to use EtlRubyWrapper:

```ruby
Copy code
require 'etl_ruby_wrapper'

# Initialize the ETL wrapper
wrapper = EtlRubyWrapper::ETL.new

# Set up paths
csv_path = "path/to/your_data.csv"
db_conn_str = "user=youruser dbname=yourdb sslmode=disable"

# Run the ETL process
begin
  wrapper.run_etl(csv_path, db_conn_str)
  puts "ETL Process Completed Successfully!"
rescue => e
  puts "An error occurred: #{e.message}"
end
```

In this example, replace csv_path and db_conn_str with the paths to your CSV file and PostgreSQL connection string, respectively.

## Development

After checking out the repo, run bin/setup to install dependencies. Use bin/console for an interactive prompt to experiment with the code.

To install this gem onto your local machine, run:

```bash
Copy code
bundle exec rake install
```

To release a new version, update the version number in version.rb, then run:

```bash
Copy code
bundle exec rake release
```

This will create a git tag for the version, push the git commits and tag, and push the .gem file to rubygems.org.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gotoAndBliss/etl_ruby_wrapper. Please feel free to open issues or contribute to improve this gem.

## License
The gem is available as open source under the terms of the MIT License.