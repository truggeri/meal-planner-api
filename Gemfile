source "https://rubygems.org" do
  gem "activemodel"
  gem "activerecord"
  gem "pg"
  gem "rake"
  gem "require_all"
  gem "sinatra"
  gem "sinatra-activerecord"

  group :test do
    gem "database_cleaner"
    gem "factory_bot"
    gem "ffaker"
    gem "minitest"
    gem "rack-test"
    gem "rubocop"
    gem "rubocop-performance"
    gem "simplecov"
  end

  group :development do
    gem "annotate"
    gem "pry"
  end

  group :development, :production do
    gem "puma"
  end

  # Sinatra-contrib needs to be included at a sub-module level (not including everything) to avoid
  #   a namespace clash in the Rakefile. Putting it in unique group so that it's not autoloaded based
  #   on running environment (dev, test, prod) and can be manually required.
  # @see https://stackoverflow.com/questions/20638136/undefined-method-desc-for-sinatraapplicationclass
  group :bad_namespace do
    gem "sinatra-contrib"
  end
end
