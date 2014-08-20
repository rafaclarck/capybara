require 'testc/tasks'
require 'cucumber/rake/task'

namespace :teste do
  namespace :run do
    desc 'Run a complete feature'
    task :feature, :feature_name do |_, params|
      ENV['FEATURE'] = Dir.glob(File.join('features', '**', "#{params[:feature_name]}.feature")).first
      Cucumber::Rake::Task.new(:run) do |task|
        task.libs << File.join(File.dirname(__FILE__), 'features', 'suport')
        task.libs << File.join(File.dirname(__FILE__), 'features', 'test_definitions')
      end
      Rake::Task[:run].invoke
    end
  end
end