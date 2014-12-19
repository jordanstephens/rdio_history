
module RdioHistory
  class History
    attr_reader :pages

    def initialize(username)
      @session = Session.new(username)
      @cursor = 0

      @pages = []
    end

    def fetch(length = DEFAULT_COUNT)
      post_data = {
        user: "#{@session.user["key"]}",
        start: @cursor,
        count: length,
        method: API::HISTORY_METHOD
      }

      response = HTTPS.post_with_session(@session, API::HISTORY_PATH, post_data)
      history_data = JSON.parse(response.body)

      if history_data.length > 0
        @cursor = history_data["result"]["last_transaction"]
        @pages << history_data["result"]
      end

      self
    end

    def sources
      @pages.map do |page|
        page["sources"]
      end.flatten
    end

    def tracks
      sources.map do |source|
        source["tracks"]
      end.flatten
    end
  end
end
