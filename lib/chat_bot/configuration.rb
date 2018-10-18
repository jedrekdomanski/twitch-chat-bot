require 'yaml'

module ChatBot
  class Configuration
    SETTINGS_FILE = ChatBot.root + '/config/settings.yml'

    attr_reader :settings

    def initialize
      @settings = YAML.load_file(SETTINGS_FILE)
    end
  end
end
