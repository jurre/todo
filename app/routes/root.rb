module TodoAPI::Routes
  class Root < Base
    get "/" do
      OpenStruct.new.extend(Representer::Root).to_json
    end
  end
end
