module Vivino

  class HowItWorksSlide < YetAnotherFramework::UI::Widget

    # disposal: true means not keeping element reference and always search it
    # it marked as disposal because by some reasons when changing slider it return same value as prev slide,
    # so basically old elements are not becoming stale as expected
    add_element :description, { xpath: './/*[@resource-id="vivino.web.app.beta:id/description"] | .//android.widget.TextView',
                                    disposal: true }
    add_element :next_btn, id: 'vivino.web.app.beta:id/next', disposal: true

    def loaded?
      %i{description next_btn}.all? do |item|
        if send(item).present?
          true
        else
          @logger.error("[#{@__fullname__}] #{item.to_s.gsub('_', ' ').capitalize} element missing!")
          false
        end
      end
    end

    def loaded!
      raise "[#{@__fullname__}] Slider is not fully loaded!" unless loaded?
    end

  end

end
