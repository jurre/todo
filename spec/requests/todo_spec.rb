require "spec_helper"

describe "Todo endpoint" do
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
  end
end
