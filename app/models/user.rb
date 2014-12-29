class Model::User < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_many :todos

  def self.authenticate(username, pass)
    user = Model::User.find(username: username)
    return false unless user && BCrypt::Password.new(user.password_hash) == pass
    user.generate_token!
    user
  end

  def validate
    super
    errors.add(:username, "cannot be empty") if !username || username.empty?
  end

  def before_create
    generate_token
    super
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Model::User.find(token: random_token)
    end
  end

  def generate_token!
    self.generate_token
    self.save
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(raw_password)
    @password = raw_password
    self.password_hash = BCrypt::Password.create(raw_password).to_s
  end
end
