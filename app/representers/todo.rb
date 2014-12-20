require "roar/decorator"
require "roar/representer/json/hal"

module Representer
  module Todo
    include Roar::Representer::JSON::HAL

    property :id
    property :title
    property :completed

    link :self do
      "/todos/#{id}"
    end
  end

  module Todo::Collection
    include Roar::Representer::JSON::HAL

    property :total

    collection :todos, extend: Todo, embedded: true

    link :self do
      "/todos"
    end
  end
end
