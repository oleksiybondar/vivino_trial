require 'UI/modules/named'
require 'UI/modules/elements_search'
require 'UI/modules/element_state'
require 'UI/modules/interactions_decorator'


module YetAnotherFramework
  module UI

    # Wrapper design pattern implementation, which wraps Selenium::WebElement actions, and provides constant framework's
    # interface
    #
    # Class has partial implementation devided to modules
    #
    # ElementSearch module from a Container class implementation, used for elements stale reference handling
    # IntractionsDecorator provides a decorated Selenium::WebElement actions wrapers
    #
    class Element

      include Named
      include ElementsSearch
      include ElementState
      include IntractionsDecorator

      attr_reader :options, :locator

      def initialize(driver_ref, parent, locator, options = {})
        @driver_ref = driver_ref
        @parent     = parent
        @locator    = locator
        @options    = options
        @logger     = YetAnotherFramework::Log::Logger.instance
        @__name__   = options[:name]
        make_fullname
      end

    end
  end
end