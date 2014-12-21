class Model::Token
  attr_reader :token, :user

  def initialize(user)
    @token = user.token
    @user = user
  end
end
