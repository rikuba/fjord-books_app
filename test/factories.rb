# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
  end

  factory :book do
    title { Faker::Book.title }
    memo { Faker::Lorem.sentence.sub('。', '') }
    author { Faker::Book.author }
  end

  factory :report do
    title { Faker::Lorem.sentence.sub('。', '') }
    content { Faker::Lorem.paragraph.gsub('。', "。\n") }
  end
end
