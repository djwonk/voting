$:.unshift File.expand_path(File.dirname(__FILE__))
require 'rubygems'

require 'ostruct'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-is-state_machine'
require 'haml'
require 'builder'

require 'voting/domain'
require 'voting/user'
require 'voting/candidate'
require 'voting/election'
require 'voting/vote'
require 'voting/helpers'

module Voting
  FILE        = File.expand_path(File.dirname(__FILE__))
  VERSION     = '0.1'
  CONFIG_PATH = "#{FILE}/config.yml"

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
    @defaults ||= {
      :root         => "#{FILE}/..",
      :database_uri => "sqlite3:///#{FILE}/../#{Sinatra::Base.environment}.db"
    }
  end
end

require 'sinatra' unless defined?(Sinatra)
require 'voting/application'
