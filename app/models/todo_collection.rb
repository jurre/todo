class Model::TodoCollection
  attr_reader :total, :todos

  def initialize(collection)
    @todos = collection
    @total = collection.count
  end
end
