require 'UI/modules/named'
require 'UI/modules/elements_search'
require 'UI/modules/element_state'
require 'UI/modules/interactions_decorator'


module YetAnotherFramework
  module UI
    class Element

      include Named
      include ElementsSearch
      include ElementState
      include IntractionsDecorator

      attr_reader   :options
      attr_reader   :locator

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