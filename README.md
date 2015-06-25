# Gkv
[![Join the chat at https://gitter.im/ybur-yug/gkv](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ybur-yug/gkv?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
<a href="https://codeclimate.com/github/ybur-yug/gkv"><img src="https://codeclimate.com/github/ybur-yug/gkv/badges/gpa.svg" /></a>

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
There are 4 main functions:

### Set

set(*key*, *value*)

```ruby
db = Gkv::Database.new
db.set('key', '12')
# => 'key'
db.set('test', 12)
# => 'test'
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

The type is inferred from when you initially set the value. Note that saving the string `'1'` will
return the integer `1` due to the naive nature of the implementation. Hashes, arrays and booleans
behave as expected when saved.

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
db.set('apples', 20.0)
db.set('ants',   'pants')
db.set('things', {})
db.all
# =>[{ 'apples': 20.0 }, { 'ants': 'pants'}, { 'things': {} }]
```

## Usage

[![asciicast](https://asciinema.org/a/0ss6cqmm6yhnyvz88bdy37oiq.png)](https://asciinema.org/a/0ss6cqmm6yhnyvz88bdy37oiq)

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the
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
