module YetAnotherFramework
  module UI

    # module implements wrappers over Selenium/Appium element actions and adds automatic logging
    #
    # it's partial implementation of Element and Widget classes
    #
    module Intractions

      # performs element click action
      #
      # @return [void]
      def click
        @driver_ref.click
        @logger.info("[#{@__fullname__}] Click on an element")
      end

      # send key sequence to the element
      #
      # @param [String] input - input sequence
      # @return [void]
      def send_keys(input)
        @driver_ref.send_keys(input)
        @logger.info("[#{@__fullname__}] Sending #{input} input to an element")
      end

      # submit a form
      #
      # @return [void]
      def submit
        @driver_ref.submit
        @logger.info("[#{@__fullname__}] Submitting form")
      end

      # clear input form entered text
      #
      # @return [void]
      #
      def clear
        @driver_ref.clear
        @logger.info("[#{@__fullname__}] Clearing input element")
      end

      # check if element is visible at the moment
      #
      # @return [Boolean]
      #
      def displayed?
        result = @driver_ref.displayed?
        @logger.info("[#{@__fullname__}] Getting element visibility: #{result}")
        result
      end

      # acquires element's attribute value
      #
      # @param [String] name - attribute name to acquire
      # @return [String]
      #
      def attribute(name)
        result = @driver_ref.attribute(name)
        @logger.info("[#{@__fullname__}] Getting element #{result} attribute: #{result}")
        result
      end

      # acquires element's text
      #
      # @return [String]
      #
      def text
        result = @driver_ref.text
        @logger.info("[#{@__fullname__}] Getting element text: #{result}")
        result
      end

    end
  end
end