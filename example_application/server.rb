require 'gkv'
require 'json'
require 'sinatra'

db = Gkv::Database.new

get '/get/:key' do
  db.get(params['key'])
end

post '/set' do
  begin
    key, value = params.fetch('key'), params.fetch('value')
    db.set(key, value)
  rescue KeyError
    { error: 'Please send key and value params in your request' }.to_json
  end
end

# tuh duh
