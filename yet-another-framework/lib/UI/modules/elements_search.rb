module YetAnotherFramework
  module UI

    # this module is a partial implementation of Container class and Element class and contains methods set helping with
    # elements search and StaleReference Errors handling
    #
    # when it takes to element search it's pretty linear, but when it takes to StaleElement reference resolution will
    # use a Chain of Responsibility Design pattern which will be implementing following algorithm:
    #
    # 1. if element action triggers StaleElement reference then trying to search element(self) again
    # 2. if stale element action happens again so that means that parent element staled then asking parent element to
    # resolve stale element, by searching parent one
    # 3. if stale element happens on parent's search resolving grand-parent
    # 4. continue until page element reached or all stales will be resolved
    #
    module ElementsSearch

      attr_accessor :parent
      attr_reader   :driver_ref

      private

      # searches element representing Element or Widget
      #
      # @return [void]
      #
      def resolve_stale_reference_error
        find_itself
      rescue Selenium::WebDriver::Error::StaleElementReferenceError
        resolve_parent_stale_reference_error
        find_itself
      end

      # searches parent element reference and resolves parent stale reference error
      #
      # @return [void]
      #
      def resolve_parent_stale_reference_error
        return unless @parent
        return unless @parent.private_methods.include?(:resolve_stale_reference_error)

        @logger.debug("[#{@__fullname__}] Resolving parent element stale reference")

        @parent.send(:resolve_stale_reference_error)
      end

      # search Selenium/Appium Element representing self object
      #
      # @return [WebElement|MobileElement]
      #
      def find_itself
        return unless @parent

        @driver_ref = nil
        type = @options.fetch(:type, :single)
        driver_ref  = find(@parent.driver_ref, @locator, type)
        @driver_ref = type == :multiple ? driver_ref[@options[:index]] : driver_ref
      end

      # performs elements search
      #
      # @param [Driver|Element] driver - search context
      # @param [Hash] locator
      # @param [Symbol] type - single element or array of elements
      # @param [Integer] attempts - search retries amount
      #
      def find(driver, locator, type, attempts = 3)
        @logger.debug("[#{@__fullname__}] Performing elements search, type: #{type}, locator: #{locator}")

        return driver.find_elements(locator) if type == :multiple

        driver.find_element(locator)
      rescue Selenium::WebDriver::Error::StaleElementReferenceError
        @logger.debug("[#{@__fullname__}] Stale reference error intercepted")
        return type == :multiple ? [] : nil if attempts <= 0

        # if some elements became stale so some DOM mutations ware occured and it might be that it still in progress so
        # a short delay needed
        sleep(1)

        resolve_parent_stale_reference_error

        find(@parent.driver_ref, locator, type, attempts - 1)
      rescue Selenium::WebDriver::Error::NoSuchElementError
        @logger.debug("[#{@__fullname__}] Element was not found!")
        nil
      end

    end
  end
end