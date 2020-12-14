

module Vivino

  # A Page object implementation for 'Top Navigation' widget of Vivino Android application, present on most of user
  # pages and also present at demo usage
  #
  class TopNavigationBar < YetAnotherFramework::UI::Widget

    add_element :charts,  id: 'vivino.web.app.beta:id/top_list_tab'
    add_element :search,  id: 'vivino.web.app.beta:id/wine_explorer_tab'
    add_element :friends, id: 'vivino.web.app.beta:id/feed_tab'
    add_element :profile, id: 'vivino.web.app.beta:id/my_profile_tab'

    # clicks on requested menu item
    #
    # @param [Symbol] menu_item - menu item anchor/alias
    # @return [AppPage] - a page for a destination page
    # @raise [RuntimeError] if requested element is missing or if not yet implemented
    #
    def navigate_to(menu_item)
      raise "Can't navigate to #{menu_item}! Method not implemented!" unless menu_item == :search

      item = send(menu_item)
      item.wait
      item.click

      map = { search: Search }.freeze

      map[menu_item].new(get_root.driver_ref)
    end
  end


end