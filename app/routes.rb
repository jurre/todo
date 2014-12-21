module TodoAPI
  module Routes
    autoload :Base, "app/routes/base"
    autoload :Todos, "app/routes/todos"
    autoload :Tokens, "app/routes/tokens"
    autoload :Users, "app/routes/users"
  end
end
