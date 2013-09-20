source 'https://rubygems.org'

gem 'rails', '3.1.2'
gem 'jquery-rails'
gem 'execjs', '1.4.0' # due to JSON bug

group :assets do
  gem 'haml-rails'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg', '~> 0.15.1' # for heroku
end

gem 'ancestry'