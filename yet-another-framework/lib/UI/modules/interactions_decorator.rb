require 'UI/modules/intractions'

module YetAnotherFramework
  module UI

    # this module implements Decorator page object pattern for Element class, it decorates all actions methods which
    # changes original behaviour by adding a mandatory element reference presence verification and StaleReference error
    # handling and retry action
    #
    module IntractionsDecorator

      include Intractions


      Intractions.instance_methods.each do |method|
        alias_method "_#{method}".to_sym, method
        define_method(method) do |*args|
          # decorates action with mandatory presence verification
          #
          present!
          # exec real action
          #
          send("_#{method}", *args)
        rescue Selenium::WebDriver::Error::StaleElementReferenceError
          # decorating Stale reference error handling
          #
          @logger.debug("[#{@__fullname__}] StaleElementReferenceError error intercepted")
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