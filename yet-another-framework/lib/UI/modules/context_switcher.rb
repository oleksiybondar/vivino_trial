module YetAnotherFramework
  module UI
    module ContextSwitcher

      # switches current context to a default(main) frame
      #
      # @return [void]
      #
      def switch_to_default_context
        @driver_ref.switch_to.default_content
        @logger.debug("[#{@__fullname__}] Switching to default content (main document)")
      end

      # switches current context to a given frame
      #
      # @param [Element|Widget] iframe - desired frame
      # @return [void]
      #
      def switch_to_iframe(iframe)
        # outerHTML acquisition will automatically checks iframe presence and trigger Stale Reference handling sequence
        # if needed
        # this call uses described above side effect, but an original result is also required, for a proper logging
        outer_html = iframe.attribute('outerHTML')

        @driver_ref.switch_to.iframe(iframe.driver_ref)
        @logger.debug("[#{@__fullname__}] Switching to iframe: #{outer_html}")
      end
    end
  end
end