module YetAnotherFramework
  module UI
    module ContextSwitcher

      def swithch_to_default_contextch
        @driver_ref.switch_to.default_content
        @logger.debug("[#{@__fullname__}] Switching to default content (main document)")
      end

      def switch_to_iframe(iframe)
        # outerHTML aquisition will automatically checks iframe presence and trigger Stale Reference handlig sequence
        # if needed
        # this call uses described above side effect, but an orifinal result is also required, for a propper logging
        outer_html = iframe.attribute('outerHTML')

        @driver_ref.switch_to.iframe(iframe.driver_ref)
        @logger.debug("[#{@__fullname__}] Switching to iframe: #{outer_html}")
      end
    end
  end
end