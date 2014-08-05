require "mongoid"
require "knowledge-net-plan-store"
Bundler.require(:test)
require "rspec"
ENV["MONGOID_ENV"] = "test"
Mongoid.load!("./sample/config/mongoid.yml")

class User
  include Mongoid::Document
  include KnowledgeNetPlanStore::User
end

RSpec.configure do |config|
  config.before :each do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:mongoid].start
  end

  config.after :each do
    DatabaseCleaner[:mongoid].clean
  end
end
