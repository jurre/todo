require "roar/representer/json/hal"

module Representer::User
  include Roar::Representer::JSON::HAL

  property :id
  property :username
end
