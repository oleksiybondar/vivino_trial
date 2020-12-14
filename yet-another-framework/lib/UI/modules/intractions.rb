module YetAnotherFramework
  module UI
    module Intractions

      def click
        @driver_ref.click
        @logger.info("[#{@__fullname__}] Click on an element")
      end

      def send_keys(input)
        @driver_ref.send_keys(input)
        @logger.info("[#{@__fullname__}] Sending #{input} input to an element")
      end

      def submit
        @driver_ref.submit
        @logger.info("[#{@__fullname__}] Submitting form")
      end

      def clear
        @driver_ref.clear
        @logger.info("[#{@__fullname__}] Clearing input element")
      end

      def displayed?
        result = @driver_ref.displayed?
        @logger.info("[#{@__fullname__}] Getting element visibility: #{result}")
        result
      end

      def attribute(name)
        result = @driver_ref.attribute(name)
        @logger.info("[#{@__fullname__}] Getting element #{result} attribute: #{result}")
        result
      end

      def text
        result = @driver_ref.text
        @logger.info("[#{@__fullname__}] Getting element text: #{result}")
        result
      end

    end
  end
end