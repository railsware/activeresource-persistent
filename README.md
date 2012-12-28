# ActiveResource::Persistent

HTTP persistent connection support for ActiveResource.

Tested with ActiveResource:

* v2.3.10
* v3.0.10
* v3.1.4
* v3.2.3
* v3.2.9

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

## SSL Support

Supported ActiveResource ssl options:

* ca_file
* cert
* cert_store
* key
* verify_mode
* verify_callback

Unsupported ActiveResource ssl options:

* ca_path
* ssl_timeout
* verify_depth

## Testing

Currently we use passenger server because it provides REMOTE_PORT enviroment variable.
Thus we can ensure that connections are persistent.

Before start suite ensure that passenger gem are installed correctly.

    $ BUNDLE_GEMFILE=Gemfile_3.2.9 bundle
    $ BUNDLE_GEMFILE=Gemfile_3.2.9 bundle exec passenger start

Run tests with:

    $ BUNDLE_GEMFILE=Gemfile_3.2.9 bundle
    $ BUNDLE_GEMFILE=Gemfile_3.2.9 bundle exec rspec -fs -c spec

    $ rake test:gemfile_2.3.10  # Testing with Gemfile_2.3.10
    $ rake test:gemfile_3.0.10  # Testing with Gemfile_3.0.10
    $ rake test:gemfile_3.1.4   # Testing with Gemfile_3.1.4
    $ rake test:gemfile_3.2.3   # Testing with Gemfile_3.2.3
    $ rake test:gemfile_3.2.9   # Testing with Gemfile_3.2.9

## References

* [activeresource](https://github.com/rails/activeresource)
* [net-http-persistent](https://github.com/drbrain/net-http-persistent)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
