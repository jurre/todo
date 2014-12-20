require "spec_helper"

describe "Todo endpoint" do
  describe "GET /todos" do
    it "returns todos" do
      get "/todos"

      expect(last_response.status).to eq(200)
    end
  end
end
