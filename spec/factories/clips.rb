require 'faker'

FactoryGirl.define do
  factory :clip do
    clip_link { Faker::Internet.url }
  end
end