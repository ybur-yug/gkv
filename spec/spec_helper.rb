$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gkv'
require 'debt_ceiling'

RSpec.configure do |config|
  config.after(:all) { DebtCeiling.audit }
end

def clear_db
  $ITEMS = {}
end

def load_db(kv_list)
  kv_list.each do |kv|
    db.set(kv.keys.first, kv.values.first)
  end
end
