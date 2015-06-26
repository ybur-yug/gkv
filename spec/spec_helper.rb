$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gkv'
require 'debt_ceiling'

RSpec.configure do |config|
  config.after(:all) { DebtCeiling.audit }
end
