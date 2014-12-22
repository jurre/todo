module Representer::User
  include Representer::Base

  property :username
  link :self do
    link_to "/users/me"
  end
end
