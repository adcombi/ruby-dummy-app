require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require_relative 'app'

module MultiEngine
  class Server
    # Accept CORS
    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*',
              headers: :any,
              methods: [:get, :post, :put, :delete, :options]
          end
        end

        run MultiEngine::App.new
      end.to_app
    end
    

    def call(env)
      # Handle the request with the Grape::API class
      response = MultiEngine::API.call(env)

      # Check if the App wants us to pass the response along to others
      if (response[1]['X-Cascade'] == 'pass')
        # Serve error pages or respond with API response
        case response[0]
        when 400..499
          Rack::Response.new( { error_message: "Client Error", error_type: "Request not available in the ::API. Request catched by ::App", status_code: response[0] }.to_json, response[0], 'Content-Type' => 'application/json').finish
        when 500..599
          Rack::Response.new( { error_message: "Server error", error_type: "Error not raised by the ::API. Error catched by ::App", status_code: response[0] }.to_json, response[0], 'Content-Type' => 'application/json').finish
        else
          response # The request should never arrive here
        end
      else # No X-Cascade header available. Response originates from MultiEngine::API
        response
      end
      
    end
  end

end