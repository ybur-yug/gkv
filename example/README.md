# Usage

## Setup
Start the server

    $ bundle
    $ ruby server.rb

 With this, in another terminal start IRB:

```ruby
require 'net/http'
require 'uri'

set_uri = URI('http://localhost:4567/set')
get_uri = URI('http://localhost:4567/get')

set_params = { :key => 'your_key', :value => 'your value' }
get_params = { :key => 'your_key' }
set_uri.query = URI.encode_www_form(set_params)
get_uri.query = URI.encode_www_form(set_params)

set_resp = Net::HTTP.get(set_uri)
get_resp = Net::HTTP.get(get_uri)
puts set_resp
# => {"key_set":"your_key"}
puts get_resp
# => your value
```
