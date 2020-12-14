
module Vivino

  class SearchItem < YetAnotherFramework::UI::Widget
    add_element :name, xpath: './/*[@resource-id="vivino.web.app.beta:id/winename_textView"]'
    add_element :winery, xpath: './/*[@resource-id="vivino.web.app.beta:id/wineryname_textView"]'
    add_element :origin, xpath: './/*[@resource-id="vivino.web.app.beta:id/winelocation_textView"]'

    def has?(keyword)
      # using String#downcase for both item test and keyword in order to have case issensitive verification
      %i[name winery origin].any? { |element| self.send(element).text.downcase.include?(keyword.downcase) }
    end

  end
end
