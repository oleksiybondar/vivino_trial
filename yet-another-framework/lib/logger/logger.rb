require 'singleton'

Dir["#{__dir__}/plugins/*.rb"].each { |plugin_file| require plugin_file}
module YetAnotherFramework
  module Log
    class Logger

      LEVELS = {debug: 0,  info: 1, message: 2, warning: 3, error: 4}.freeze
      NONE   = :none

      include Singleton
      attr_reader   :level
      attr_reader   :plugins
      attr_accessor :disabled_plugins

      def debug(message)
        # stub method added in order to have a documentation methods, the body itself will be a copy-paste, so actuall
        # body will be definned down bellow using define_method
        #
        # same for rest loggign methods
      end
      def info(message); end
      def message(message); end
      def warning(message); end
      def error(message); end

      LEVELS.keys.each do |k|
        define_method(k) do |message|
          return unless log?(__method__)

          log(__method__, message)
        end
      end

      def initialize(level = :info)
        raise "Bag argument error: #{level.class}, log level sould be Symbol and one of the following #{LEVELS.keys}" unless level.is_a?(Symbol)
        raise "Invalid log level #{level}, it should be one of the following #{LEVELS.keys} and #{NONE}" unless LEVELS[level] || level == NONE

        @level = level


        @plugins = Log::Plugins.constants.map { |plugin| Log::Plugins.const_get(plugin).new }
        @disabled_plugins = []
      end

      def level=(level)
        raise "Bag argument error: #{level.class}, log level sould be Symbol and one of the following #{LEVELS.keys}" unless level.is_a?(Symbol)
        raise "Invalid log level #{level}, it should be one of the following #{LEVELS.keys} and :#{NONE}" unless LEVELS[level] || level == NONE

        @level = level
      end

      private

      def log?(level)
        return false if @level == NONE

        LEVELS[@level] <= LEVELS[level]
      end

      def log(level, message)
        @plugins.each do |plugin|
          plugin.send(level, message) unless @disabled_plugins.include?(plugin.class.to_s.split('::').last.to_sym)
        end
      end

    end
  end
end