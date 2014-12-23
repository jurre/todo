require "json"

module TodoAPI::Routes
  class Base < Sinatra::Application
    before do
      content_type "application/hal+json"
      headers "Access-Control-Allow-Origin" => "*",
        "Access-Control-Allow-Methods" => %w(OPTIONS GET POST PATCH PUT DELETE),
        "Access-Control-Allow-Headers" => %w(Content-Type X-Authorization X-Requested-With),
        "Allow" => %w(OPTIONS GET POST PATCH PUT DELETE)
      merge_json_body_params
    end

    options "*" do
      halt 200
    end

    set :protection, false

    private

    def require_authentication
      halt 401, { message: "invalid_token" }.to_json unless current_user
    end

    def current_user
      @current_user ||= Model::User.find(token: env["HTTP_X_AUTHORIZATION"])
    end

    def merge_json_body_params
      request.body.rewind
      begin
        params.merge! JSON.parse(request.body.read, symbolize_keys: true)
      rescue JSON::ParserError
      end
    end
  end
end
