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

  describe "GET /users/me" do
    let(:user) { Model::User.create(username: "Flanders", password: "diddlydoo") }

    it "returns the current user" do
      allow_any_instance_of(TodoAPI::Routes::Users).to receive(:current_user) { user }

      get "/users/me"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)["username"]).to eq("Flanders")
    end
  end
end
