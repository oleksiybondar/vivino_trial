module YetAnotherFramework
  module UI
    module ElementsSearch

      attr_accessor :parent
      attr_reader   :driver_ref

      private

      def resolve_stale_reference_error
        find_itself
      rescue Selenium::WebDriver::Error::StaleElementReferenceError
        resolve_parent_stale_reference_error
        find_itself
      end

      def resolve_parent_stale_reference_error
        return unless @parent
        return unless @parent.private_methods.include?(:resolve_stale_reference_error)

        @logger.debug("[#{@__fullname__}] Resolving parent element stale reference")

        @parent.send(:resolve_stale_reference_error)
      end

      def find_itself
        return unless @parent

        @driver_ref = nil
        type = @options.fetch(:type, :single)
        driver_ref  = find(@parent.driver_ref, @locator, type)
        @driver_ref = type == :multiple ? driver_ref[@options[:index]] : driver_ref
      end


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
        @logger.debug("[#{@__fullname__}] Element was not found")
        nil
      end

    end
  end
end