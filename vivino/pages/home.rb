require_relative 'search'
require_relative 'widgets/top_navigation_bar'

module Vivino

  # A Page object implementation for 'Home' screen of Vivino Android application, this page usually appears right after
  # user sign-up/sign-in page and when clicking 'Try us out' at the last page of 'How it Works' slider
  #
  class Home < YetAnotherFramework::UI::AppPage

    # a Frameworks Page Object API was implemented with keeping in mind about Composite/TreeView structure of PO
    # implementation, adding nested Page object inside of current one
    #
    # a reusable component to can be used an any pare with Top navigation bar
    add_element :nav_bar,   id: 'vivino.web.app.beta:id/tabs', klass: TopNavigationBar
    add_element :user_name, id: 'vivino.web.app.beta:id/user_name'
  end

end