module Representer::Token
  include Representer::Base

  property :token
  property :user, embedded: true, extend: Representer::User
end
