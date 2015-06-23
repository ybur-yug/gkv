# Gkv
[![Join the chat at https://gitter.im/ybur-yug/gkv](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ybur-yug/gkv?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Gkv is a simple git wrapper that allows you to use it as a kv store

![proof in our pudding](http://i.imgur.com/EKdt7oR.png)

The documentation says thats what it does. So why not yo?

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

## API
There are 3 main functions:

### Set

set(*key*, *value*, *type*)
Type defaults to `s`, while `i` and `f` are also acceptable

```ruby
db = Gkv::Database.new
db.set('key', '12') # no type declaration defaults to string
# input is all coerced to the string type and returned when set
# => 'key'
db.set('test', 12, 'i')
# => 'test'
db.get('test')
# => 12
# note that the 'i' sets to int
```

### Get
get(*key*)

```ruby
db = Gkv::Database.new
db.set('apples', '10')
# => 'apples'
db.get('apples')
# => '10'
```

### Get Version

get_version(*version*, *key*)

```ruby
db = Gkv::Database.new
db.set('apples', '20')
# => 'apples'
db.set('apples', '50')
# => 'apples'
db.get_version(1, 'apples')
# => '20'
db.get_version(2, 'apples')
# => '50'
```

### All

all

```ruby
db.set('apples', '10')
db.set('ants',   10, 'i')
db.set('things', '10')
db.all
# =>[{ 'apples': '10' }, { 'ants': 10 }, { 'things': '10' }]
```

## Usage

```ruby
db = Gkv::Database.new

db.set('Apples', '10')
# => 'Apples'
db.get('Apples')
# => '10'

# update some values
db.set('Apples', '12')
# => 'Apples'
db.get('Apples')
# => '12'
db.get_version(1, 'Apples')
#=> '10'

# keys that do not exist return KeyError
db.get('magic')
# => KeyError
```

There is an example application included in the `example_app` directory that utilizes Sinatra

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
