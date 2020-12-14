
module Vivino

  # A Page object implementation for 'SearchItem' widget of Vivino Android application's 'Search' page,
  # represent a single result on a search page
  #
  class SearchItem < YetAnotherFramework::UI::Widget
    add_element :name, xpath: './/*[@resource-id="vivino.web.app.beta:id/winename_textView"]'
    add_element :winery, xpath: './/*[@resource-id="vivino.web.app.beta:id/wineryname_textView"]'
    add_element :origin, xpath: './/*[@resource-id="vivino.web.app.beta:id/winelocation_textView"]'

    # check's if a given keyword contains inside of name, winery and origin fields
    #
    # @param [String] keyword - keyword to check
    # @return [Boolean]
    # @raise [RuntimeError] if any of required elements is missing
    #
    def has?(keyword)
      # using String#downcase for both item test and keyword in order to have case issensitive verification
      %i[name winery origin].any? { |element| self.send(element).text.downcase.include?(keyword.downcase) }
    end

  end
end
