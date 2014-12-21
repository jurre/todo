ENV["RACK_ENV"] = "test"

require "rack/test"
require "rspec"

require File.expand_path("../../app.rb", __FILE__)

CONTENT_TYPE_JSON = { "CONTENT_TYPE" => "application/json" }

# some convenience methods for posting json
["post", "patch", "put"].each do |method|
  define_method("#{method}_json") do |endpoint, params|
    send(method, endpoint, params.to_json, CONTENT_TYPE_JSON)
  end
end

module RbConfig
  include Rack::Test::Methods
  def app
    TodoAPI::App
  end
end

RSpec.configure do |config|
  config.include RbConfig
  config.around(:each) do |spec|
    Sequel::Model.db.transaction(rollback: :always) { spec.run }
  end
end
