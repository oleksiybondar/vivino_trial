require_relative 'search'
require_relative 'widgets/top_navigation_bar'

module Vivino

  class Home < YetAnotherFramework::UI::AppPage
    add_element :nav_bar,   id: 'vivino.web.app.beta:id/tabs', klass: TopNavigationBar
    add_element :user_name, id: 'vivino.web.app.beta:id/user_name'
  end

end