require "roar/representer/json/hal"

module Representer::Token
  include Roar::Representer::JSON::HAL

  property :token
  property :user, embedded: true, extend: Representer::User
end
