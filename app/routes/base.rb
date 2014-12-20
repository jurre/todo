module TodoAPI::Routes
  class Base < Sinatra::Application
    before do
      content_type "application/hal+json"
    end
  end
end
