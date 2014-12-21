require "spec_helper"

describe "Token endpoint" do
  describe "POST /tokens" do
    let(:auth_params) do
      { username: "Phillip Fry", password: "Slurm!1" }
    end
    let!(:user) { Model::User.create(auth_params) }

    it "creates a new token" do
      post_json "/tokens", auth_params

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to include({
        "token" => user.token
      })
    end

    it "returns a 401 for invalid credentials" do
      post_json "/tokens", { username: "Phillip Fry", password: "incorrect" }

      expect(last_response.status).to eq(401)
    end
  end
end
