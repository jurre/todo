require "spec_helper"

describe Representer::User do
  it "serializes correctly" do
    user = double(:user, id: 1, token: "some_token", username: "Picard")
    represented = user.extend(Representer::User).to_hash

    expect(represented).to eq({
      "username" => "Picard",
      "_links" => {
        "self" => { href: "#{ENV["BASE_URL"]}/users/me" }
      }
    })
  end
end
