require 'sinatra'
require 'json'
require 'gkv'

DB = Gkv::Database.new

get '/' do
  { all_items: DB.all }.to_json
end

get '/set' do
  begin
    key, value = params.fetch('key'), params.fetch('value')
    DB.set(key, value)
    { key_set: key }.to_json
  rescue KeyError
    { error: 'error setting key/value pair, please send key and value params' }.to_json
  end
end

get '/get' do
  begin
    key = params.fetch('key')
    DB.get(key)
  rescue KeyError
    { error: 'error retrieving key. it either does not exist or you did not send a parameter `key`' }.to_json
  end
end
