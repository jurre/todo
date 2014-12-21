require "spec_helper"

describe "Users endpoint" do
  describe "POST /users" do
    it "creates a new user" do
      user_params = { username: "Bart", password: "sk8board" }

      post_json "/users", user_params

      expect(last_response.status).to eq(200)
      expect(Model::User.find(username: "Bart")).to_not eq(nil)
    end

    it "returns a 400 for invalid params" do
      invalid_params = { some: "invalid params" }

      post_json "/users", invalid_params

      expect(last_response.status).to eq(400)
    end
  end
end
