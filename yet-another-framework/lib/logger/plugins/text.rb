require 'date'

module YetAnotherFramework
  module Log
    module Plugins
      class Text

        LOGS_FOLDER = "#{Dir.pwd}/logs"
        LOG_TIMESTAMP = "%d_%m_%Y__%H_%M_%S__%N"

        attr_reader :file_name

        def initialize
          Dir.mkdir(LOGS_FOLDER) unless Dir.exists?(LOGS_FOLDER)
          @file_name = "#{LOGS_FOLDER}/#{Time.now.strftime(LOG_TIMESTAMP)}.txt"
        end

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

        SEPARATOR = ' | '

        TIMESTAMPMASK = '%d-%m-%Y %H:%M:%S.%L'

        LABELS.keys.each do |k|
          define_method(k) do |message|
            open(@file_name, 'a') { |f| f.puts [Time.now.strftime(TIMESTAMPMASK), LABELS[k].ljust(7), message].join(SEPARATOR) }
          end
        end

      end
    end
  end
end


