# Thredded::Pushover::Notifier

A notifier for [Thredded](https://github.com/thredded/thredded/) allowing push notifications to be sent via [Pushover](https://pushover.net/)

## Installation

Add this line to your application's Gemfile

```ruby
gem 'thredded-pushover-notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thredded-pushover-notifier

## Usage

* You will need a Pushover app token (see the first option on https://pushover.net/api)
* Let's assume you've added your Pushover app token as an environment variable `PUSHOVER_APP_TOKEN`.
* You will need to have Thredded working already (at least v0.13.4) and have an iniializer already created.
* Let's assume your app is being served at http://example.com


Let's assume

To setup two notifiers - email and pushover, add the following to the bottom of your thredded.rb initializer:

```ruby
Thredded::Engine.config.to_prepare do
  require 'thredded/pushover_notifier/content_helper'
  Thredded::PushoverNotifier::ContentHelper.include Thredded::Engine.routes.url_helpers
  pushover_notifier = Thredded::PushoverNotifier.new(ENV['PUSHOVER_APP_TOKEN'],  'http://example.com')
  Thredded.notifiers = [Thredded::EmailNotifier.new, pushover_notifier]
end
```


 


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/thredded-pushover-notifier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

