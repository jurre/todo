require "spec_helper"

describe Representer::Todo do
  it "serializes correctly" do
    todo = double(:todo, id: 1, title: "Serialize me", completed: true)
    represented = todo.extend(Representer::Todo).to_hash

    expect(represented).to eq({
      "title" => "Serialize me",
      "completed" => true,
      "_links" =>  {
        "self" => { href: "#{ENV["BASE_URL"]}/todos/1" }
      }
    })
  end

  it "parses correctly" do
    todo = Model::Todo.new.extend(Representer::Todo)
    json_body = { title: "Do the laundry" }.to_json

    todo.from_json(json_body)

    expect(todo.title).to eq("Do the laundry")
  end
end

describe Representer::Todo::Collection do
  it "serializes correctly" do
    todos = [].tap do |t|
      2.times do |i|
        t << double(:todo, id: i, title: "task #{i}", completed: false)
      end
    end
    represented = Model::TodoCollection.new(todos).
      extend(Representer::Todo::Collection).to_hash

    expect(represented[:_embedded]["todos"].count).to eq(2)
    expect(represented).to include({"total" => 2})
  end
end
