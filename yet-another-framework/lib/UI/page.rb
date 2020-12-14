require 'UI/container'
require 'UI/modules/named'
require 'UI/modules/context_switcher'

require 'selenium-webdriver'

module YetAnotherFramework
  module UI

    # a base class for concrete Page Objects for Appium testing, provides a context switching, page manipulations API and
    # elements creation helper, with build in logging
    #
    # NOTE does not designed for standalone usage
    class Page < Container

      include Named
      include ContextSwitcher

      # starts browser instance using given capabilities
      #
      # @param [Symbol] name - name of desired browser
      # @param [Hash] caps - Selenium capabilities
      # @return [AppPage]
      #
      def self.start_browser(name = :chrome, caps = {} )
        self.new(Selenium::WebDriver.for(name, caps))
      end

      # creates an Page instance
      #
      # @param [Selenium::WebDriver] - a reference for a driver
      #
      def initialize(driver_ref = nil)
        super(driver_ref)

        @__name__ = self.class.to_s.split('::').last
        make_fullname
      end

      # current page title getter
      #
      # @return [String]
      #
      def title
        @driver_ref.title
      end

      # opens given URL in a currently opened tab
      #
      # @param [String] url - desired URL
      # @return [Void]
      #
      def open(url)
        @driver_ref.get(url)
        @logger.info("[#{@__fullname__}] Opening #{url} URL")
      end

    end
  end
end
