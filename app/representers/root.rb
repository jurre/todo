require "roar/representer/json/hal"

module Representer::Root
  include Roar::Representer::JSON::HAL

  link(:self) { "#{ENV["BASE_URL"]}/" }
  link(:todos) { "#{ENV["BASE_URL"]}/todos" }
  link(:tokens) { "#{ENV["BASE_URL"]}/tokens" }
  link(:users) { "#{ENV["BASE_URL"]}/users" }
end
