ENV['RACK_ENV'] ||= 'test'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new
require 'rack/test'

include Rack::Test::Methods

require File.expand_path '../../app.rb', __FILE__

def app
  App
end

# Create a custom class inheriting from minitest::spec for your unit tests
class MiniTest::Spec
  def json_parse(body)
    JSON.parse(body, symbolize_names: true)
  end
end
