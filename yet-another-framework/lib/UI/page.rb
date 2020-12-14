require 'UI/container'
require 'UI/modules/named'
require 'UI/modules/context_switcher'

require 'selenium-webdriver'

module YetAnotherFramework
  module UI
    class Page < Container

      include Named
      include ContextSwitcher

      def self.start_browser(name = :chrome, caps = {} )
        self.new(Selenium::WebDriver.for(name, caps))
      end

      def initialize(driver_ref = nil)
        super(driver_ref)

        @__name__ = self.class.to_s.split('::').last
        make_fullname
      end

      def title
        @driver_ref.title
      end

      def open(url)
        @driver_ref.get(url)
        @logger.info("[#{@__fullname__}] Opening #{url} URL")
      end



    end
  end
end
