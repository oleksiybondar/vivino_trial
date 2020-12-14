module YetAnotherFramework
  module UI
    module ContentSwitcher

      # switches application content to NATIVE APP
      #
      # @return [void]
      #
      def switch_to_native_content
        @driver_ref.set_context('NATIVE_APP')
        @logger.debug("[#{@__fullname__}] Switching to Native App context")
      end

      # switches application content to currently active web content
      #
      # @return [void]
      #
      def switch_to_web_content
        contexts = wait_for_context

        context = case contexts.size
                  # contents.size normally will not produce 0, hovewer there are cases then Appium server returns an
                  # empty response on failed operation, such behaviour is extreamelly rare, but still handling this
                  # edge case
                  when 0, 1 then raise "[#{@__fullname__}] Web content unavailable!"
                  when 2    then contexts.last
                  else
                    # normally available context should return 2 contexts 1st - Native_app and 2nd - active webview,
                    # however there are cases when amount of webviews is more than 1, for example iOS emulators, may
                    # keep used webview id's or most common slider implementration when each slider item implemented as
                    # a separate web page, so it this case we need to find a visible one
                    return select_web_context(contexts)
                  end

        raise "[#{@__fullname__}] Web content unavailable!" if contexts.size == 1

        @driver_ref.set_context(context)
        @logger.debug("[#{@__fullname__}] Switching to #{context} Web context")
      end

      private

      # waits until contexts amount will be more than 1
      #
      # return [Array<string>]
      #
      def wait_for_context
        contexts = []
        Timeout.timeout(YetAnotherFramework::Config.wait_timeout) do
          while contexts.size < 2
            sleep 1
            contexts = @driver_ref.available_contexts rescue %w{NATIVE_APP}
          end
        end
        contexts
      rescue TimeoutError
        %w{NATIVE_APP}
      end

      # Searches currently active web context among array of web contexts
      #
      # @param [Array<String>] contexts
      #
      def select_web_context(contexts)
        contexts.each do |context|
          begin
            @driver_ref.set_context(context)
            visible = @driver_ref.execute_script('return document.visibilityState') == 'visible' rescue false

            @logger.debug("[#{@__fullname__}] Switching to #{context} Web context and checking if it's visible: #{visible}")
            return
          rescue
            @logger.debug("[#{@__fullname__}] Switching to #{context} Web context failed")
          end
        end

        @logger.warning("[#{@__fullname__}] Unable to find visible webview! Using last successesfully switched context")
      end

    end
  end
end
