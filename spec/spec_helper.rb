ENV["RACK_ENV"] = "test"

require "rack/test"
require "rspec"

require File.expand_path("../../app.rb", __FILE__)

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
