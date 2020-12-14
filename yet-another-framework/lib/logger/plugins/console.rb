require 'date'

module YetAnotherFramework
  module Log
    module Plugins

      # a logger Console output plugin
      #
      class Console

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

        LABELS = { debug: 'DEBUG', info: 'INFO', message: 'MESSAGE', warning: 'WARNING', error: 'ERROR' }.freeze

        OUTPUTS = { debug: $stdout, info: $stdout, message: $stdout, warning: $stdout, error: $stderr }.freeze

        SEPARATOR = ' | '

        TIMESTAMPMASK = '%d-%m-%Y %H:%M:%S.%L'

        # defining actual logging methods bodies, building them on the fly since method body will be the same for each
        # of the log levels the only difference is a log level
        LABELS.keys.each do |k|
          define_method(k) do |message|
            OUTPUTS[k].puts [Time.now.strftime(TIMESTAMPMASK), LABELS[k].ljust(7), message].join(SEPARATOR)
          end
        end

      end
    end
  end
end

