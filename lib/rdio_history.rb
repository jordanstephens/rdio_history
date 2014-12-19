require "json"

require "rdio_history/https"
require "rdio_history/api"
require "rdio_history/history"
require "rdio_history/session"
require "rdio_history/version"

module RdioHistory
  DEFAULT_COUNT = 10

  def self.fetch(username, length = DEFAULT_COUNT)
    History.new(username).fetch(length)
  end
end
