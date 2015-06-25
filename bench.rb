require 'gkv'
require 'benchmark'

gkv = Gkv::Database.new

n = 1000

Benchmark.bm do |x|
  x.report("set:\t\t") { n.times { gkv.set('Apple', 10) } }
  x.report("hash set:\t") { n.times { gkv['Apple'] = 10 } }
  x.report("get:\t\t") { n.times { gkv.get('Apple') } }
  x.report("hash get:\t") { n.times { gkv['Apple'] } }
end
