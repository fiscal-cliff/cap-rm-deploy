# Capistrano::Rmdeploy

=Capistrano 3 version=
-Supports only git-

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/cap/rm/deploy`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-rmdeploy'
```

And then execute:

    $ bundle

Or install it yourself (tested) as:

    $ gem install cap-rm-deploy

You also should add the line bellow to your Capfile:

```ruby
require 'capistrano/rmdeploy'
```

## Usage

The initializer for this gem may looks like this:

```ruby
Capistrano::Rmdeploy.configure do |config|
    config.site = 'http://localhost:3000'
    config.user = 'admin'
    config.password = 'admin'
    config.status_id_to_update = [1,3]
    config.done_status_id = 3
    config.key = 'qSHC6HhOiAAQVECJv4Ig'
end
```

You should add this line in stage, that requires redmine tasks update (production):

```ruby
after "deploy:finished", "redmine:default"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/fiscal-cliff/cap-rm-deploy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
