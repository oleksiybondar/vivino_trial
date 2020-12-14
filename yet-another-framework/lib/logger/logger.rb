require 'singleton'

# Automatically require all the logger plugins files
Dir["#{__dir__}/plugins/*.rb"].each { |plugin_file| require plugin_file}


module YetAnotherFramework
  module Log

    # Problem statement:
    # Detailed logging in automation project is one of the most important things, so implementing a Logger class, which
    # will have constant interface across all the framework.
    # Requirements:
    # - logger should have multiple logging levels and configurable minimum
    # - logger should be a Singleton class in order to have sequential logging across the framework and application
    # - logger should support different output formats
    # Implementation notes:
    # Implementing Logger using Listener Design Pattern in order to support different output formats without changing the
    # logger itself, new formats should be implemented as logger plugin
    #
    class Logger

      LEVELS = { debug: 0, info: 1, message: 2, warning: 3, error: 4 }.freeze
      NONE   = :none

      include Singleton

      attr_reader :level, :plugins
      attr_accessor :disabled_plugins

      # logs message with debug output level
      #
      # @param [String] message - text to post
      # @return [Void]
      #
      def debug(message)
        # stub method added in order to have a documentation methods, the body itself will be a copy-paste, so actuall
        # body will be defined down bellow using define_method
        #
        # same for rest logging methods
      end

      # logs message with info output level
      #
      # @param [String] message - text to post
      # @return [Void]
      #
      def info(message); end

      # logs message with message output level
      #
      # @param [String] message - text to post
      # @return [Void]
      #
      def message(message); end

      # logs message with warning output level
      #
      # @param [String] message - text to post
      # @return [Void]
      #
      def warning(message); end

      # logs message with debug output level
      #
      # @param [String] message - text to post
      # @return [Void]
      #
      def error(message); end

      # defining actual logging methods bodies, building them on the fly since method body will be the same for each
      # of the log levels the only difference is a log level
      LEVELS.keys.each do |k|
        define_method(k) do |message|
          return unless log?(__method__)

          log(__method__, message)
        end
      end

      def initialize(level = :info)
        raise "Bag argument error: #{level.class}, log level should be Symbol and one of the following #{LEVELS.keys}" unless level.is_a?(Symbol)
        raise "Invalid log level #{level}, it should be one of the following #{LEVELS.keys} and #{NONE}" unless LEVELS[level] || level == NONE

        @level = level


        @plugins = Log::Plugins.constants.map { |plugin| Log::Plugins.const_get(plugin).new }
        @disabled_plugins = []
      end

      # log level setter implementation which adds argument type and value verifications
      #
      # @param [Symbol] level - a new minimum log level
      # @return [Symbol]
      # @raise [RuntimeError] if invalid argument type or value
      def level=(level)
        raise "Bag argument error: #{level.class}, log level should be Symbol and one of the following #{LEVELS.keys}" unless level.is_a?(Symbol)
        raise "Invalid log level #{level}, it should be one of the following #{LEVELS.keys} and :#{NONE}" unless LEVELS[level] || level == NONE

        @level = level
      end

      private

      # checks if given log level should be logged
      #
      # @param [Symbol] level - desired log level
      # @return [Boolean]
      #
      def log?(level)
        return false if @level == NONE

        LEVELS[@level] <= LEVELS[level]
      end

      # actually logs the given message with a given log level
      #
      # @param [Symbol] level - desired level
      # @param [String] message - message to post
      #
      def log(level, message)
        @plugins.each do |plugin|
          plugin.send(level, message) unless @disabled_plugins.include?(plugin.class.to_s.split('::').last.to_sym)
        end
      end

    end
  end
end