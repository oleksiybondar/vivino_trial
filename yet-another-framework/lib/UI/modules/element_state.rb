require 'timeout'

module YetAnotherFramework
  module UI
    module ElementState

      # checks if element reference present
      #
      # @return [void]
      # @raise [RuntimeError] if element is missing
      #
      def present!
        raise "[#{@__fullname__}] Element missing!" unless present?
      end

      # checks if element reference present
      #
      # @return [Boolean]
      #
      def present?
        result = !@driver_ref.nil?
        @logger.info("[#{@__fullname__}] Getting element presense: #{result}")
        result
      end

      # wait until elements found
      #
      # @return [Boolean]
      #
      def wait(timeout = YetAnotherFramework::Config.wait_timeout, delay = 1)
        Timeout.timeout(timeout) do
          until present?
            sleep(delay)
            find_itself
          end
        end
      end

      # retrieves a root element from subfree element
      #
      # @return [Page|AppPage]
      #
      def get_root
        parent = @parent
        parent = parent.parent until parent.parent.nil?
        parent
      end

    end
  end
end