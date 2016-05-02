require './artists_api'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins 'localhost'
    resource '*', headers: :any, methods: :get
  end
end

run Artists::API
