require "spec_helper"

describe Representer::Token do
  it "serializes correctly" do
    user = double(:user, id: 1, token: "some_token", username: "Luke")
    token = Model::Token.new(user)
    represented = token.extend(Representer::Token).to_hash

    expect(represented).to eq({
      "token" => "some_token",
      :_embedded => {
        "user" => {
          "username" => "Luke"
        }
      }
    })
  end
end
