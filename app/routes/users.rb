module TodoAPI::Routes
  class Users < Base
    post "/users" do
      user = Model::User.new(user_params)
      if user.valid?
        user.save.extend(Representer::User).to_json
      else
        status 400
        user.errors.to_json
      end
    end

    def user_params
      { username: params["username"], password: params["password"] }
    end
  end
end
