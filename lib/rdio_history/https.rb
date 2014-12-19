require "singleton"

module RdioHistory
  class HTTPS
    include Singleton

    attr_reader :https

    def initialize
      @https = Net::HTTP.new(API::BASE_URL, 443)
      @https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @https.use_ssl = true
    end

    def self.post_with_session(session, path, data)
      data.merge!({
        "_authorization_key" => session.authorization_key
      })

      data = data.map{ |k, v| "#{k}=#{v}" }.join("&")

      headers = {
        "Cookie" => session.authorization_cookie
      }

      self.post(path, data, headers)
    end

    def self.method_missing(name, *args, &block)
      if self.instance.https.respond_to?(name, include_private = false)
        self.instance.https.send(name, *args, *block)
      else
        super
      end
    end
  end
end
