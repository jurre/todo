module TodoAPI::Routes
  class Todos < Base
    get "/todos" do
      todos = Model::Todo.order(:id).all
      Model::TodoCollection.new(todos).
        extend(Representer::Todo::Collection).to_json
    end

    get "/todos/:id" do
      todo = Model::Todo.find(id: params[:id])
      todo.extend(Representer::Todo).to_json
    end
  end
end
