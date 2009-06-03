#!/usr/bin/env ruby

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
require "#{File.dirname(__FILE__)}/../lib/voting"
require 'vegas'

Vegas::Runner.new(Voting::Application, 'app')
