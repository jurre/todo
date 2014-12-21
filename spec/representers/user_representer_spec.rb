require "spec_helper"

describe Representer::User do
  it "serializes correctly" do
    user = double(:user, id: 1, token: "some_token", username: "Picard")
    represented = user.extend(Representer::User).to_hash

    expect(represented).to eq({
      "id" => 1,
      "username" => "Picard"
    })
  end
end