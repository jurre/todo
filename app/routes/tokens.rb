module TodoAPI::Routes
  class Tokens < Base
    post "/tokens" do
      if user = Model::User.authenticate(params[:username], params[:password])
        Model::Token.new(user).extend(Representer::Token).to_json
      else
        status 401
      end
    end
  end
end
