
Before do
  require_relative '../../Vivino/pages/landing'
  @config = YAML.load_file("#{__dir__}/config.yaml")
  # HARD CODING INTENTIONALLY
  # overwriting it intentionly, because we need to be sure that app is operable with this trial test
  @config[:caps][:app] = "#{__dir__}/../../bin/vivino-trial-app.apk"
  YetAnotherFramework::Log::Logger.instance.level = @config[:log_level] || :info
  @page = Vivino::Landing.start_application(@config[:caps], @config[:appium_server])
end

After do
  @page.driver_ref.quit
end