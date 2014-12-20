module Model
  class Todo < Sequel::Model
    plugin :timestamps, update_on_create: true
  end
end
