module Routing
  module Base

    def self.registered(app)
      app.get '/?' do
        content_type :json
        return { status: 'ok'}.to_json
      end

      app.get '/info.json' do
        content_type :json
        return { author: 'Egbert Pot', version: '1.0.0' }.to_json
      end
    
    end
  end
end