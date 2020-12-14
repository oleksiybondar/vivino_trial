require 'UI/container'
require 'UI/modules/named'
require 'UI/modules/content_switcher'
require 'UI/modules/context_switcher'


require 'selenium-webdriver'
require 'appium_lib'

module YetAnotherFramework
  module UI

    # a base class for concrete Page Objects for Appium testing, provides a context and content switching API and
    # elements creation helper, with build in logging
    #
    # NOTE does not designed for standalone usage
    class AppPage < Container

      include Named
      include ContentSwitcher
      include ContextSwitcher

      # starts appium device using given capabilities and on desired appium server
      #
      # @param [Hash] caps - Appium capabilities object
      # @param [Hash] server_options - appium server options
      # @return [AppPage]
      #
      def self.start_application(caps = {}, server_options = {})
        self.new(Appium::Driver.new(caps: caps, appium_lib: server_options).start_driver())
      end

      # creates an AppPage instance
      #
      # @param [Appium::Driver] - a reference for a driver
      #
      def initialize(driver_ref = nil)
        super(driver_ref)

        @__name__ = self.class.to_s.split('::').last
        make_fullname
      end
    end
  end
end
