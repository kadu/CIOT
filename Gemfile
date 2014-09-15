source 'https://rubygems.org'

# Specify ruby version (Heroku requirement)
ruby "1.9.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Use postgres in production
gem 'pg', group: :production

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'			#test framework 
  gem 'factory_girl_rails'					#create fixtures for tests
  gem 'timecop'											#create time mockups
  ################## DATABASE ########################
  # Use mysql as the database for Active Record
  gem 'mysql2'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# gem 'web-console', '2.0.0.beta2', group: :development

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

# Devise for user management
gem 'devise'

gem 'rails_12factor', group: :production

# Bootstrap to make layout beautiful
gem 'bootstrap-sass', '~> 3.2.0'
# Bootstrap recommends (add browser vendor prefixes automatically)
gem 'autoprefixer-rails'
