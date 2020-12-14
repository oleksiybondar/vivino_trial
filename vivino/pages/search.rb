require_relative 'widgets/top_navigation_bar'
require_relative 'widgets/search_item'

module Vivino

  class Search < YetAnotherFramework::UI::AppPage
    add_element :nav_bar,        id: 'vivino.web.app.beta:id/tabs', klass: TopNavigationBar
    add_element :search_btn,     id: 'vivino.web.app.beta:id/search_vivino'
    add_element :search_query,   id: 'vivino.web.app.beta:id/editText_input'
    add_element :search_results, xpath: '//*[@resource-id="vivino.web.app.beta:id/pager"]//android.widget.FrameLayout', klass: SearchItem, type: :multiple

    def search_wine(keyword)
      search_btn.wait
      search_btn.click
      search_query.wait
      search_query.send_keys keyword
    end

    def wait_for_results
      # wait is not implemented for a multiple type

      timeout = Time.now + YetAnotherFramework::Config.wait_timeout
      # if empty then it will trigger a find_itself loop automatically
      # NOTE Rubie's Timeout fails find_elements loop, so using alternative implementation
      sleep 1 while search_results.size.zero? && Time.now < timeout

      search_results.any?(&:present?)
    end

    def search_results_has_keyword(keyword)
      search_results.each_with_index do |result, i|
        if result.has?(keyword)
          @logger.info("Search result #{i} contains given #{keyword}")
        else
          raise "Search result #{i} does not contains give #{keyword}"
        end
      end
    end
  end

end
