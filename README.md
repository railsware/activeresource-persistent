# ActiveResource::Persistent

HTTP persistent connection support for ActiveResource.

Tested with ActiveResource:

* v2.3.10
* v3.0.10
* v3.1.4
* v3.2.3

## Installation

Add this line to your application's Gemfile:

    gem 'activeresource-persistent', :require => 'active_resource/persistent'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeresource-persistent

## Usage

Works out of box after adding:

    require 'active_resource/persistent'

## Testing

Currently we use passenger server because it provides REMOTE_PORT enviroment variable.
Thus we can ensure that connections are persistent.

    $ BUNDLE_GEMFILE=Gemfile_3_2_3 bundle
    $ BUNDLE_GEMFILE=Gemfile_3_2_3 bundle exec rspec -fs -c spec

    $ rake test:gemfile_2_3_10  # Testing with Gemfile_2.3.10
    $ rake test:gemfile_3_0_10  # Testing with Gemfile_3.0.10
    $ rake test:gemfile_3_1_4   # Testing with Gemfile_3.1.4
    $ rake test:gemfile_3_2_3   # Testing with Gemfile_3.2.3

## References

* [activeresource](https://github.com/rails/activeresource)
* [net-http-persistent](https://github.com/drbrain/net-http-persistent)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
