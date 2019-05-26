Rails.application.config.generators do |g|
  g.assets false
  g.helper false

  g.test_framework :rspec, fixtures: true
  g.fixture_replacement :factory_bot, dir: 'spec/factories'
  g.view_specs false
  g.helper_specs false
  g.decorator   false
end
