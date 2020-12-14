require_relative 'home'
require_relative 'widgets/how_it_works_slide'

module Vivino

  # Page Object model for a Landing Page of Vivino Android application, this PO described as multi-state page, it was
  # assumed that it's a single component, it covers initial Landing screen, How it Works. If that's  different
  # components it's possible to split them for a separate PO as an enhancement item
  #
  class Landing < YetAnotherFramework::UI::AppPage

    def initialize(driver_ref = nil)
      super(driver_ref)
      # automatically handles genymotion error at creation time
      handle_genymotion_error
    end

    # initial screen buttons
    add_element :slogan,           id: 'vivino.web.app.beta:id/desc_text'
    add_element :get_started_btn,  id: 'vivino.web.app.beta:id/getstarted_layout'
    add_element :how_it_works_btn, id: 'vivino.web.app.beta:id/seehowitwork'

    # slider
    add_element :how_it_works_slide, xpath: '//*[@resource-id="vivino.web.app.beta:id/viewFlipperproductshowcase"][last()]', klass: HowItWorksSlide
    # # last slide buttons
    add_element :continue_with_email,    id: 'vivino.web.app.beta:id/continue_with_email'
    add_element :continue_with_facebook, id: 'vivino.web.app.beta:id/continue_with_facebook'
    add_element :continue_with_google,   id: 'vivino.web.app.beta:id/continue_with_google'

    # footer
    add_element :try_out_btn, id: 'vivino.web.app.beta:id/txtTryUsOut'
    add_element :sign_in_btn, id: 'vivino.web.app.beta:id/txthaveaccount'

    # Geny motion specific(see misc/genymotion_err.png), not reproducible on Android Studio
    add_element :genymotion_err_ok_btn, id: 'android:id/button1'

    # closes Android warning about missing Google Appssee misc/genymotion_err.png) if it exists
    #
    # @return [void]
    def handle_genymotion_error
      genymotion_err_ok_btn.click if genymotion_err_ok_btn.present?
    end

    # wait until 'Try us out' will be found and click on it
    #
    # @return [Vivino::Home] - an instance of Home Page object
    # @raise [RuntimeError] if some of required elements was not found
    #
    def try_out_application
      try_out_btn.wait
      try_out_btn.click

      Home.new(@driver_ref)
    end

  end
end
