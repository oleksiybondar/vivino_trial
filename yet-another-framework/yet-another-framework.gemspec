
Gem::Specification.new do |gem|
  gem.name          = 'yet-another-framework'
  gem.version       = '0.1.0'
  gem.date          = Time.now.strftime('%Y-%m-%d')

  gem.authors       = ['Oleksiy Bondar']
  gem.email         = ['bondaroleksiyandriyovich@gmail.com']
  gem.homepage      = ''

  gem.summary       = 'A collection of classes which simplifies Page object definition'
  gem.description   = 'A collection of classes which simplifies Page object definition, targeted for Appium.io and/or Selenium tests execution. Provides a high-level API, reducing amount of repetitive appium specific code and and extend Page Object Pattern with Composit Pattern to achieve more granuable and  reusable tree view objects structure inside of page object'
  gem.executables   = []
  gem.files         = ['lib/yet-another-framework.rb']
  gem.test_files    = []
  gem.require_paths = ['lib']

  gem.add_dependency 'selenium-webdriver'
  gem.add_dependency 'appium_lib'
end
