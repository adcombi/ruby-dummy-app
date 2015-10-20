require "sinatra/base"
require "sinatra/namespace"

Dir[File.join(File.dirname(__FILE__), 'models', 'base.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), 'api', '**', '*.rb')].each {|file| require file }


class App < Sinatra::Base
  register Sinatra::Namespace
  register Routing::Base

end