require 'socket'
require 'logger'

module ChatBot
  class Twitch < Channel

    TWITCH_CHAT_TOKEN = ENV['TWITCH_CHAT_TOKEN']

    attr_reader :socket

    def initialize(*args)
      super
      @socket = nil
    end

    def send_message(message)
      logger.info "< #{message}"
      socket.puts(message)
    end

    def run
      ready = IO.select([socket])

      ready[0].each do |s|
        line    = s.gets
        match   = line.match(/^:(.+)!(.+) PRIVMSG #(.+) :(.+)$/)
        message = match && match[4]

        if message =~ /^!hello/
          user = match[1]
          logger.info "USER COMMAND: #{user} - !hello"
          send_message "PRIVMSG #0jedrek0 :Hello, #{user}! Welcome to the channel. "
        end

        logger.info "> #{line}"
      end
    end

    def stop
      @running = false
    end

    private

    def initialize_channel
      username = ChatBot.config.settings['twitch']['username']
      server   = ChatBot.config.settings['twitch']['server']
      port     = ChatBot.config.settings['twitch']['port']

      logger.info "Preparing to connect to Twitch as #{username}..."

      @socket = TCPSocket.new(server, port)
      socket.puts("PASS #{TWITCH_CHAT_TOKEN}")
      socket.puts("NICK #{username}")

      logger.info 'Connected...'
    end
  end
end
