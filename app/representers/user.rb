require "roar/representer/json/hal"

module Representer::User
  include Roar::Representer::JSON::HAL

  property :username
  link :self do
    "#{ENV["BASE_URL"]}/users/me"
  end
end
