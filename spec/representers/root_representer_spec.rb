require "spec_helper"

describe Representer::Root do
  it "serializes correctly" do
    represented = OpenStruct.new.extend(Representer::Root).to_hash

    expect(represented).to eq({
      "_links" => {
        "self" => {
          href: "#{ENV["BASE_URL"]}/"
        },
        "users" => {
          href: "#{ENV["BASE_URL"]}/users"
        },
        "todos" => {
          href: "#{ENV["BASE_URL"]}/todos"
        },
        "todo" => {
          href: "#{ENV["BASE_URL"]}/todos/{id}",
          templated: true
        },
        "tokens" => {
          href: "#{ENV["BASE_URL"]}/tokens"
        },
        "current_user" => {
          href: "#{ENV["BASE_URL"]}/users/me"
        }
      }
    })
  end
end
