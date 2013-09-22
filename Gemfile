source 'https://rubygems.org'
# ruby '1.9.2'

gem 'rails', '3.1.6'
gem 'jquery-rails'
gem 'execjs', '1.4.0' # due to JSON bug
gem 'haml-rails'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :test do
  gem 'database_cleaner', '1.0.1' # https://github.com/bmabey/database_cleaner/issues/224
  gem 'rspec-rails'
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg', '~> 0.15.1' # for heroku
end

gem 'ancestry'
gem 'dalli'