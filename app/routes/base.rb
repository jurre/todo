require "json"

module TodoAPI::Routes
  class Base < Sinatra::Application
    before do
      content_type "application/hal+json"
      headers "Access-Control-Allow-Origin" => "*",
        "Access-Control-Allow-Methods" => %w(OPTIONS GET POST PUT DELETE),
        "Access-Control-Allow-Headers" => "Content-Type"
      merge_json_body_params
    end

    set :protection, false

    private

    def merge_json_body_params
      request.body.rewind
      begin
        params.merge! JSON.parse(request.body.read, symbolize_keys: true)
      rescue JSON::ParserError
      end
    end
  end
end
