require 'spec/rake/spectask'

namespace :spec do
  task :failfast do
    system("#{RAILS_ROOT}/script/spec --require spec/support/formatters/fail_fast_formatter.rb --format FailFastFormatter spec")
  end
end
