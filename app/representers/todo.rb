module Representer
  module Todo
    include Representer::Base

    property :title
    property :completed

    link :self do
      link_to "/todos/#{id}"
    end
  end

  module Todo::Collection
    include Representer::Base

    property :total

    collection :todos, extend: Todo, embedded: true

    link :self do
      link_to "todos"
    end
  end
end
