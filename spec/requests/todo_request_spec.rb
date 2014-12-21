require "spec_helper"

describe "Todo endpoint" do
  before(:each) do
    user = double(:user)
    allow_any_instance_of(TodoAPI::Routes::Todos).to receive(:current_user) { user }
  end

  describe "GET /todos" do
    it "returns todos" do
      get "/todos"

      expect(last_response.status).to eq(200)
    end
  end

  describe "GET /todos/:id" do
    it "returns a single todo" do
      todo = Model::Todo.create(title: "Make this endpoint work")
      serialized_todo = todo.extend(Representer::Todo).to_json

      get "/todos/#{todo.id}"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(serialized_todo)
    end

    it "returns a 404 when not found" do
      get "/todos/128"
      expect(last_response.status).to eq(404)
    end
  end

  describe "POST /todos" do
    it "creates a new todo" do
      todo_params = { title: "Allow people to post new todos" }

      expect {
        post_json "/todos", todo_params
      }.to change { Model::Todo.count }.by(1)
      expect(last_response.status).to eq(200)
    end

    it "returns a 422 for invalid requests" do
      invalid_params = { some_random_key: "LOL this won't work!" }

      post_json "/todos", invalid_params
      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)).to eq({
        "title" => ["cannot be empty"]
      })
    end
  end

  describe "PATCH /todos/:id" do
    let(:todo) { Model::Todo.create(title: "We need to complete todos, right?!") }

    it "updates a todo" do
      params = { completed: true }

      patch_json "/todos/#{todo.id}", params

      expect(last_response.status).to eq(200)
      expect(todo.reload.completed).to eq(true)
    end

    it "returns a 400 for invalid requests" do
      invalid_params = { title: nil }

      patch_json "/todos/#{todo.id}", invalid_params

      expect(last_response.status).to eq(400)
    end

    it "returns a 404 when the todo can't be found" do
      params = { completed: true }

      patch_json "/todos/123", params

      expect(last_response.status).to eq(404)
    end
  end

  describe "DELETE /todos/:id" do
    let(:todo) { Model::Todo.create(title: "Allow deleting todos") }

    it "deletes the todo" do
      delete "/todos/#{todo.id}"

      expect(last_response.status).to eq(200)
      expect(todo.exists?).to eq(false)
    end
  end
end
