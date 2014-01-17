require 'rubygems'
require 'bundler/setup'

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require "before_filters"

RSpec.configure do |config|
  config.order = 'random'
end
