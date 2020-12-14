require 'timeout'

module YetAnotherFramework
  module UI
    module ElementState

      def present!
        raise "[#{@__fullname__}] Element missing!" unless present?
      end

      def present?
        result = !@driver_ref.nil?
        @logger.info("[#{@__fullname__}] Getting element presense: #{result}")
        result
      end

      def wait(timeout = YetAnotherFramework::Config.wait_timeout, delay = 1)
        Timeout::timeout(timeout) do
          while !present?
            sleep(1)
            find_itself
          end
        end
      end

      def get_root
        parent = @parent
        parent = parent.parent while !parent.parent.nil?
        parent
      end

    end
  end
end