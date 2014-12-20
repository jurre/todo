module TodoAPI::Routes
  class Base < Sinatra::Application
    before do
      content_type "application/hal+json"
      headers "Access-Control-Allow-Origin" => "*",
        "Access-Control-Allow-Methods" => %w(OPTIONS GET POST PUT DELETE),
        "Access-Control-Allow-Headers" => "Content-Type"
    end

    set :protection, false
  end
end
