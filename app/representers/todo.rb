require "roar/representer/json/hal"

module Representer
  module Todo
    include Roar::Representer::JSON::HAL

    property :id
    property :title
    property :completed

    link :self do
      "#{ENV["BASE_URL"]}/todos/#{id}"
    end
  end

  module Todo::Collection
    include Roar::Representer::JSON::HAL

    property :total

    collection :todos, extend: Todo, embedded: true

    link :self do
      "#{ENV["BASE_URL"]}/todos"
    end
  end
end
