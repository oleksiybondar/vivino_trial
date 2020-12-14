require 'UI/container'
require 'UI/modules/named'
require 'UI/modules/elements_search'
require 'UI/modules/element_state'
require 'UI/modules/interactions_decorator'
require 'selenium-webdriver'

module YetAnotherFramework
  module UI

    # a mix of Container and Element classes, basically it's an advanced version of Element class which may contains
    # child elements
    #
    # NOTE this class was not designed for a standalone usage, it should be inherited by a concrete widget
    # #
    class Widget < Container

      include Named
      include ElementState
      include IntractionsDecorator

      attr_reader   :options
      attr_reader   :locator


      def initialize(driver_ref, parent, locator, options = {})
        super(driver_ref, parent)
        @locator    = locator
        @options    = options
        @__name__   = options[:name]
        make_fullname
      end

    end
  end
end

