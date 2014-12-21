class Model::Todo < Sequel::Model
  plugin :timestamps, update_on_create: true
  many_to_one :user

  def validate
    super
    errors.add(:title, "cannot be empty") if !title || title.empty?
  end
end
