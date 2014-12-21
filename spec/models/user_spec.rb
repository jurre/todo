require "spec_helper"

describe Model::User do
  describe "validations" do
    it "requires a username" do
      expect(Model::User.new.valid?).to eq(false)
      expect(Model::User.new(username: "Homer").valid?).to eq(true)
    end
  end

  it "generates a random token" do
    user = Model::User.create(username: "Kirk", password: "s3cur3")
    expect(user.token).to_not eq(nil)
  end

  it "encrypts the password" do
    password = "Leia12!@"
    user = Model::User.create(username: "Han Solo", password: password)
    expect(user.password_hash).to_not eq(password)
    expect(user.password_hash).to_not be("")
  end

  describe ".authenticate " do
    let!(:user) { Model::User.create(username: "Archer", password: "duchess009") }

    it "authenticates existing users" do
      expect(Model::User.authenticate("Archer", "duchess009")).to eq(user)
    end

    it "fails with wrong password" do
      expect(Model::User.authenticate("Archer", "nope")).to eq(false)
    end
  end
end
