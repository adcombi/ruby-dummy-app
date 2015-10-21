# ENV['RACK_ENV'] ||= 'development'

# require 'bundler'
# Bundler.require :default, ENV['RACK_ENV'].to_sym
# require_relative 'app'

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = "test/**/*_test.rb"
  # t.warning = true
  t.verbose = true
end

task default: :test

###

# desc "Simple list of API routes"
# task :simple_routes do
#   App.routes.each do |api|
#     method = api.route_method.ljust(10)
#     path = api.route_path
#     puts "     #{method} #{path}"
#   end
# end