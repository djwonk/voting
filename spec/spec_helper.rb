require 'rubygems'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
require 'rspec_hpricot_matchers'

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
require "#{File.dirname(__FILE__)}/../lib/voting"

# set test environment
Voting::Application.set :environment, :test
Voting::Application.set :run, false
Voting::Application.set :raise_errors, true
Voting::Application.set :logging, false

require "#{File.dirname(__FILE__)}/factories"

# establish in-memory database for testing
DataMapper.setup(:default, "sqlite3::memory:")

Spec::Runner.configure do |config|
  # include additional matchers
  config.include(RspecHpricotMatchers)

  # reset database before each example is run
  config.before(:each) { DataMapper.auto_migrate! }
end
