ENV["RACK_ENV"]    = "test"
ENV["RAILS_ENV"]   = "test"
ENV["SINATRA_ENV"] = "test"

require_relative "../config/environment"

require "minitest/autorun"
require "rack/test"

require "database_cleaner"
DatabaseCleaner.strategy = :truncation

module Minitest
  class Test
    include FactoryBot::Syntax::Methods
    FactoryBot.find_definitions

    def setup
      DatabaseCleaner.clean
    end

    def after
      DatabaseCleaner.clean
    end

    def random_characters(length)
      return nil if length < 1
      length = Random.rand(50) if length.nil?
      FFaker::Lorem.characters(length)
    end
  end
end
