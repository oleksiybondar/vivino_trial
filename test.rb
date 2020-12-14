require 'bundler/setup'
require 'yet-another-framework'


logger = YetAnotherFramework::Log::Logger.instance
logger.level = :debug

Selenium::WebDriver::Chrome::Service.driver_path = '/Users/oleksiybondar/Documents/development/jet/core/bin/macosx/chromedriver_87/chromedriver'


class GoogleSearchResult < YetAnotherFramework::UI::Widget
  add_element :title, tag_name: 'h3'
  add_element :description, xpath: './/h3/following::div'

  def print_the_result
    _title       = title.text
    _description = description.present? ? description.text : ''

    @logger.message("[#{__fullname__}] result:\nTitle: #{_title}\nDescription: #{_description}")
  end
end

class GoogleSearch < YetAnotherFramework::UI::Page

  add_element :search_query,  name: 'q'
  add_element :search_button, xpath: '//input[@name=\'q\']/following::button | //input[@name=\'q\']/following::center/input'
  # NOTE this locator may not work since Google has dynamic class generation on each deploy/build
  add_element :search_results, css: '#search [data-async-context] .g', klass: GoogleSearchResult, type: :multiple

end


page = GoogleSearch.start_browser
page.open('https://www.google.com/')
page.search_query.send_keys 'ruby'
page.search_query.submit
s_result_1 = page.search_results[1]

s_result_1.print_the_result

page.search_query.clear
page.search_query.send_keys 'php'
page.search_button.click

s_result_1.print_the_result

page.search_query.clear
page.search_query.send_keys 'java'
page.search_button.click

s_result_1.print_the_result