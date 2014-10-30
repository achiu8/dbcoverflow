module ApplicationHelper
  def get_quote
    uri = "https://api.github.com/zen"
    headers = { "User-Agent" => "Httparty" }
    auth = { username: "achiu8", password: "jtbt7cfd1lrmgw" }
    response = HTTParty.get(uri, headers: headers, basic_auth: auth)

    p response
    
    if response.code == 200
      response.body
    else
      Faker::Lorem.sentence
    end
  end
end
