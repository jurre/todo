module TodoAPI::Routes
  class Todos < Base
    get "/todos" do
      todos = Model::Todo.order(:id).all
      Model::TodoCollection.new(todos).
        extend(Representer::Todo::Collection).to_json
    end

    get "/todos/:id" do
      if todo = Model::Todo.find(id: params[:id])
        todo.extend(Representer::Todo).to_json
      else
        status 404
      end
    end

    post "/todos" do
      todo = Model::Todo.new(todo_params)
      if todo.valid?
        todo.save.extend(Representer::Todo).to_json
      else
        status 400
        todo.errors.to_json
      end
    end

    private

    def todo_params
      { title: params[:title] }
    end
  end
end
