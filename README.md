# ActiveResource::Persistent

HTTP persistent connection support for ActiveResource.

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

    $ bundle
    $ bundle exec rspec -fs -c spec

## References

* [activeresource](https://github.com/rails/activeresource)
* [net-http-persistent](https://github.com/drbrain/net-http-persistent)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
