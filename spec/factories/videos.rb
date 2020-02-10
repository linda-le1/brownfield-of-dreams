FactoryBot.define do
  factory :video do
    title { Faker::Pokemon.name }
    description { Faker::SiliconValley.motto }
    video_id { Faker::Crypto.md5 }
    thumbnail { 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg' }
    position { 1 }
    tutorial
  end
end
