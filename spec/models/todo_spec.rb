require "spec_helper"

describe Model::Todo do
  describe "validations" do
    it "requires a title" do
      expect(Model::Todo.new.valid?).to eq(false)
      expect(Model::Todo.new(title: "Hi!").valid?).to eq(true)
    end
  end
end
