module TodoAPI::Routes
  class Todos < Base
    before "/todos*" do
      require_authentication
    end

    get "/todos" do
      todos = Model::Todo.where(user: current_user).all
      Model::TodoCollection.new(todos).
        extend(Representer::Todo::Collection).to_json
    end

    get "/todos/:id" do
      if todo = Model::Todo.find(id: params[:id], user: current_user)
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

    patch "/todos/:id" do
      if todo = Model::Todo.find(id: params[:id], user: current_user)
        if todo.set(todo_params).valid?
          todo.save.extend(Representer::Todo).to_json
        else
          status 400
          todo.errors.to_json
        end
      else
        status 404
      end
    end

    delete "/todos/:id" do
      if todo = Model::Todo.find(id: params[:id], user: current_user)
        todo.destroy
      else
        status 404
      end
    end

    private

    def todo_params
      {
        title: params["title"],
        completed: params["completed"],
      }.select! { |k, _| params.has_key?(k.to_s) }
        .merge(user: current_user)
    end
  end
end
