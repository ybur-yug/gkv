require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

require 'mutant'

RSpec::Core::RakeTask.new(:spec)

task :fuzz do
  status = Mutant::CLI.run(%w[--use rspec --require gkv --use rspec Gkv::GitFunctions])

  if status.nonzero?
    puts 'Mutant task was not successful'
  else
    puts 'Mutant task was successful'
  end
end

task :default => [ :spec, :fuzz ]
