require 'UI/modules/intractions'

module YetAnotherFramework
  module UI
    module IntractionsDecorator

      include Intractions

      # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
      # decorator itself
      # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

      Intractions.instance_methods.each do |method|
        alias_method "_#{method}".to_sym, method
        define_method(method) do |*args|
          # decorates action with mandatory presence verification
          #
          present!
          # exec real action
          #
          send("_#{method}", *args)
        rescue Selenium::WebDriver::Error::StaleElementReferenceError, Selenium::WebDriver::Error::InvalidElementStateError => e
          # decorating Stale reference error handling
          #
          @logger.debug("[#{@__fullname__}] #{e.class} error intercepted")
          resolve_stale_reference_error

          # yet another presence verification, since element may not be found after stale reference handler
          #
          present!
          # retrying and action
          #
          send("_#{method}", *args)
        end
      end

      # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
      # EOF decorator
      # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

    end
  end
end