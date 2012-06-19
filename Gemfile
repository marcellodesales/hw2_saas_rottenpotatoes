source 'http://rubygems.org'

gem 'rails', '3.2.5'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'ruby-tmdb'

# for Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'sqlite3'
  gem 'debugger'
  gem 'database_cleaner' # to clear Cucumber’s test database between runs
  gem 'capybara'  # lets Cucumber pretend to be a web browser
  gem 'launchy' # a useful debugging aid for user stories 
  gem 'rspec-rails'
end

group :test do
  gem 'cucumber-rails'
  gem 'cucumber-rails-training-wheels' # some pre-fabbed step definitions
  gem 'autotest'
  gem 'factory_girl_rails'
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'therubyracer'              
  gem 'sass-rails', "  ~> 3.2.5"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
gem 'haml'
