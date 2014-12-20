module Model
  class Todo < Sequel::Model
    plugin :timestamps, update_on_create: true

    def validate
      super
      errors.add(:title, "cannot be empty") if !title || title.empty?
    end
  end
end
