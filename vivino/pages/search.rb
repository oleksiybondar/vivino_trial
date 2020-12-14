require_relative 'widgets/top_navigation_bar'
require_relative 'widgets/search_item'

module Vivino

  # A Page object implementation for 'Search' screen of Vivino Android application
  #
  class Search < YetAnotherFramework::UI::AppPage

    # a Frameworks Page Object API was implemented with keeping in mind about Composite/TreeView structure of PO
    # implementation, adding nested Page object inside of current one
    #
    # a reusable component to can be used an any pare with Top navigation bar
    add_element :nav_bar,        id: 'vivino.web.app.beta:id/tabs', klass: TopNavigationBar
    add_element :search_btn,     id: 'vivino.web.app.beta:id/search_vivino'
    add_element :search_query,   id: 'vivino.web.app.beta:id/editText_input'

    # a Frameworks Page Object API was implemented with keeping in mind about Composite/TreeView structure of PO
    # implementation, adding nested Page object inside of current one
    #
    # each result has exactly the same structure
    add_element :search_results, xpath: '//*[@resource-id="vivino.web.app.beta:id/pager"]//android.widget.FrameLayout', klass: SearchItem, type: :multiple

    # enters given keyword into a wine search query
    #
    # @param [String] keyword - a keyword or text to search
    # @return [void]
    # @raise [RuntimeError] if some of required elements was not found
    #
    def search_wine(keyword)
      # at the initial state of Search page we can see a search input, but that's a fake, it's clickable object which
      # transforms and after clicking on it actual search query araise
      search_btn.wait
      search_btn.click
      search_query.wait
      search_query.send_keys keyword
    end

    # wait until search result will be found
    #
    # @return [void]
    #
    def wait_for_results
      # wait is not implemented for a multiple type

      timeout = Time.now + YetAnotherFramework::Config.wait_timeout
      # if empty then it will trigger a find_itself loop automatically
      # NOTE Rubie's Timeout fails find_elements loop, so using alternative implementation
      sleep(1) until !search_results.size.zero? || Time.now > timeout

      search_results.any?(&:present?)
    end

    # checks that wine all of search results contains given keyword
    #
    # @param [String] keyword - a keyword check
    # @return [void]
    # @raise [RuntimeError] if some of required elements was not found or keyword was not found
    #
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
