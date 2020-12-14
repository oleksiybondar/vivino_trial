require 'UI/element'
require 'UI/modules/elements_search'

module YetAnotherFramework
  module UI

    # Problem statement:
    # most Page Object patten implementations contains a log of repetitive code related to elements search and
    # StaleReferenceErrors handling, so unified elements search and stale errors handlers should be implemented.
    # Additionally most modern Websites/Application pages are composite and consist of reusable components/widgets so
    # testing framework should also following composite tree view moder to achieve more granulate and reusable page
    # objects
    # Requirements:
    # - find elements should be hidden inside of testing framework
    # - elements search should also handle stale elements reference error
    # - simple test writer's API
    # Implementation notes:
    # this class is nod designed for a standalone usage
    # Class Hierarchy
    #                      Container
    #       /                |              \
    # ApplicationPage     Web Page           Widget
    #       |                |                  \
    # Concrete App Page  Concrete web Page   Concrete Widget
    #
    # Application Page may consist of Elements and/or Widgets
    # Web Page may consist of Elements and/or Widgets
    # Widgets may consist of Elements and/or Widgets
    # Widget implements both Container and Element interfaces
    #
    # Class has partial implementation split into modules in order to have same implementation on other classes
    #
    class Container

      include ElementsSearch

      def initialize(driver_ref, parent = nil)
        @driver_ref = driver_ref
        @parent     = parent
        @logger     = YetAnotherFramework::Log::Logger.instance
      end

      # a helper for a public usage, should simplify concrete Page Objects definitions, adds an access method for a
      # web/mobile element and perform automatic element search and stale reference error during elements search
      #
      # @param [Symbol] name - element name, access method will be created with a given name
      # @param [options] options - options containing locator and search behavior options
      # @return [void]
      #
      def self.add_element(name, options = {})
        YetAnotherFramework::Log::Logger.instance.debug("Creating accessor for #{self}.#{name} element; options: #{options}")
        define_method(name) do
          element = instance_variable_get("@_#{name}")

          return element if element && (!options[:disposal] || element.is_a?(Array) && element.size.zero?)

          # name key will be interfering with name locator key
          build_element(options.merge(_name: name)) # duplication options in order to have them intact, build element
          # will mutate options
        end
      end

      # split's locator and helper options from a single set
      #
      # @param [&Hash] options - helper options, will mutate options to locator
      # @return [Hash] helper options
      #
      def extract_builder_options(options)
        { klass:    options.delete(:klass)    || Element,
          type:     options.delete(:type)     || :single,
          disposal: options.delete(:disposal) || false,
          name:     options.delete(:_name) }
      end

      private

      # create an Element or Widget at runtime after accessing to an element and performs element search
      #
      # @param [Hash] options - helper options
      # @return [Element|Widget]
      #
      def build_element(options)
        # extract builder options will remove all builder specific keys, so options == locator
        builder_options = extract_builder_options(options)
        driver_ref = find(@driver_ref, options, builder_options[:type])
        element = wrap(driver_ref, builder_options[:klass], options, builder_options)
        instance_variable_set("@_#{builder_options[:name]}", element)
      end

      # wrap's Selenium/Appium reference with Element or Widget
      #
      # @param [WebElement|MobileElement|Array<WebElement|MobileElement>] driver_ref
      # @param [Class] klass - class to instantiate
      # @param [Hash] locator - search criteria
      # @param [Hash] options - helper options
      # @return [Widget|Element]
      #
      def wrap(driver_ref, klass, locator, options)
        return driver_ref.each_with_index.map { |ref, i| wrap(ref, klass, locator, options.merge(index: i)) } if driver_ref.is_a?(Array)

        klass.new(driver_ref, self, locator, options)
      end

    end

  end
end