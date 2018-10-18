module ChatBot

  def self.config
    @config = Configuration.new
  end

  def self.root
    @root ||= File.expand_path('../../', __FILE__)
  end
end

require 'chat_bot/channel'
require 'chat_bot/configuration'
require 'chat_bot/twitch'
