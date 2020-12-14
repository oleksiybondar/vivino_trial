require 'date'

module YetAnotherFramework
  module Log
    module Plugins
      class Console

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

        LABELS = { debug: 'DEBUG', info: 'INFO', message: 'MESSAGE', warning: 'WARNING', error: 'ERROR' }.freeze

        OUTPUTS = { debug: $stdout, info: $stdout, message: $stdout, warning: $stdout, error: $stderr }.freeze

        SEPARATOR = ' | '

        TIMESTAMPMASK = '%d-%m-%Y %H:%M:%S.%L'

        LABELS.keys.each do |k|
          define_method(k) do |message|
            OUTPUTS[k].puts [Time.now.strftime(TIMESTAMPMASK), LABELS[k].ljust(7), message].join(SEPARATOR)
          end
        end

      end
    end
  end
end

