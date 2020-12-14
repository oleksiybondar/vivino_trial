require 'UI/element'
require 'UI/modules/elements_search'

module YetAnotherFramework
  module UI

    class Container

      include ElementsSearch

      def initialize(driver_ref, parent = nil)
        @driver_ref = driver_ref
        @parent     = parent
        @logger     = YetAnotherFramework::Log::Logger.instance
      end

      def self.add_element(name, options = {})
        YetAnotherFramework::Log::Logger.instance.debug("Creating accessor for #{self}.#{name} element; options: #{options}")
        define_method(name) do
          element = instance_variable_get("@_#{name}")

          return element if element && (!options[:disposal] || element.is_a?(Array) && element.size.zero?)

          # name key will be interfering with name locator key
          build_element(options.merge(_name: name)) # duplication options in order to have them intact, build element will mutate options
        end
      end

      def extract_builder_options(options)
        {
          klass:    options.delete(:klass)   || Element,
          type:     options.delete(:type)    || :single,
          context:  options.delete(:context) || :web,
          disposal: options.delete(:disposal) || false,
          name:     options.delete(:_name)
        }
      end

      private

      def build_element(options)
        # extract builder options will remove all builder specific keys, so options == locator
        builder_options = extract_builder_options(options)
        driver_ref = find(@driver_ref, options, builder_options[:type])
        element = wrapp(driver_ref, builder_options[:klass], options, builder_options)
        instance_variable_set("@_#{builder_options[:name]}", element)
      end

      def wrapp(driver_ref, klass, locator, options)
        return driver_ref.each_with_index.map { |ref, i| wrapp(ref, klass, locator, options.merge(index: i)) } if driver_ref.is_a?(Array)

        klass.new(driver_ref, self, locator, options)
      end

    end

  end
end