# Gkv
[![Join the chat at https://gitter.im/ybur-yug/gkv](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ybur-yug/gkv?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Gkv is a simple git wrapper that allows you to use it as a kv store

#### DO NOT use this in real software at its current state.

#### This is the product of a [tutorial](https://github.com/ybur-yug/git_kv_store_tutorial) I wrote to explore git.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gkv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gkv

## Usage

```ruby
db = Gkv::Database.new

db.set("Apples", "10")
db.get("Apples")
# => "10"

# update some values
db.set("Apples", "12")
db.get("Apples")
# => "12"
db.get_version(1, "Apples")
#=> 10

# using it in sinatra
require 'sinatra'
require 'json'

post '/' do
  db.set(params['key'], params['value')
  { msg: "#{params['key']} set to #{params['value']}" }.to_json
  rescue
    { error: "Please send key and value params" }.to_json
  end
end

get '/get/:key' do
  { key: db.get(params['key']) }.to_json
end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the
tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version,
update the version number in `version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Feel free to check out the gitter room and ask whats on the agenda.

Bug reports and pull requests are welcome on GitHub at https://github.com/ybur-yug/gkv. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

See [this](http://www.wtfpl.net/about/).
