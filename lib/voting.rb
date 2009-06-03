$:.unshift File.expand_path(File.dirname(__FILE__))
require 'rubygems'

require 'ostruct'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-is-state_machine'
require 'haml'

require 'voting/domain'
require 'voting/user'
require 'voting/candidate'
require 'voting/election'
require 'voting/vote'

module Voting
  VERSION     = '0.1'
  CONFIG_PATH = "#{File.expand_path(File.dirname(__FILE__))}/config.yml"

  def self.config
    @config ||= load_config
  end

  def self.load_config
    config = default_config.dup

    if File.exists?(CONFIG_PATH)
      config.merge(YAML.load_file(CONFIG_PATH))
    else
      config
    end
  end

  def self.default_config
    @defaults ||= { :root         => "#{File.expand_path(File.dirname(__FILE__))}/..",
                    :database_uri => "sqlite3:///#{File.expand_path(File.dirname(__FILE__))}/../#{Sinatra::Base.environment}.db"
                    #:database_uri => "sqlite3::memory:",
                  }
  end
end

require 'sinatra' unless defined?(Sinatra)
require 'voting/application'
