require 'UI/container'
require 'UI/modules/named'
require 'UI/modules/content_switcher'
require 'UI/modules/context_switcher'


require 'selenium-webdriver'
require 'appium_lib'

module YetAnotherFramework
  module UI
    class AppPage < Container

      include Named
      include ContentSwitcher
      include ContextSwitcher

      def self.start_application(caps = {}, server_options = {} )
        self.new(Appium::Driver.new(caps: caps, appium_lib: server_options).start_driver())
      end

      def initialize(driver_ref = nil)
        super(driver_ref)

        @__name__ = self.class.to_s.split('::').last
        make_fullname
      end
    end
  end
end
