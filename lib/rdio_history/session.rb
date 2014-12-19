
module RdioHistory
  class Session
    attr_reader :authorization_key, :authorization_cookie, :user

    def initialize(username)
      # Get a response from any page that sends back tokens
      response = HTTPS.get(API::PEOPLE_PATH)

      # Now strip out the (presumably) CSRF token
      @authorization_key = response.body.match(/authorizationKey"\: "([^"]+)/)[1]
      # Strip out the autorization Cookie
      set_cookie = response.get_fields("Set-Cookie")
      @authorization_cookie = set_cookie.join("").scan(/_a="(.+)?"/).first.first
      @user = fetch_user(username)
    end

    def fetch_user(username)
      params = {
        url: "people/#{username}/",
        method: API::USER_METHOD
      }

      response = HTTPS.post_with_session(self, API::USER_PATH, params)

      json_data = JSON.parse(response.body)
      json_data["result"]
    end
  end
end
