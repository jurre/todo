require "spec_helper"

describe "Root endpoint" do
  describe "GET /" do
    it "returns a HAL index" do
      get "/"
      root = OpenStruct.new.extend(Representer::Root).to_json

      expect(last_response.status).to eq(200)
      expect(last_response.body). to eq(root)
    end
  end
end
