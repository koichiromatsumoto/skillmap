source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

gem 'rails', '~> 5.2.0'
gem 'settingslogic'
gem 'dotenv-rails'
gem 'kaminari'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'slim-rails'
gem 'devise'
gem 'ranked-model'

# assets
gem 'coffee-rails', '~> 4.2'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap', '~> 4.0.0'
gem 'sass-rails', '~> 5.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'

# DB
group :mysql do
  gem 'mysql2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'thin'
  gem 'web-console', '>= 3.3.0'
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'rubocop', '~> 0.57.2', require: false
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # pry
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
end

group :production, :staging do
  gem 'mini_racer', platforms: :ruby
  gem 'unicorn'
end
