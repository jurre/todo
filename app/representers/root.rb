module Representer::Root
  include Representer::Base

  link(:self) { link_to "/" }
  link(:todos) { link_to "/todos" }
  link(:todo) do
    { href: link_to("/todos/{id}"), templated: true }
  end
  link(:tokens) { link_to "/tokens" }
  link(:users) { link_to "/users" }
  link(:current_user) { link_to "/users/me" }
end
