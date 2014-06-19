require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
#########################################
OmniAuth.config.test_mode = true
omniauth_hash =
    {:provider => "facebook",
     :uid      => "1234",
     :info   => {:name       => "John Doe",
                 :email      => "johndoe@email.com"},
     :credentials => {:token => "testtoken234tsdf"}}

OmniAuth.config.add_mock(:facebook, omniauth_hash)
########################################

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|


  config.use_transactional_fixtures = false

  config.before(:suite) do

      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

