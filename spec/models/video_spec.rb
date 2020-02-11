require 'rails_helper'

RSpec.describe Video, type: :model do
    describe 'validations' do
        it { should validate_presence_of :position}
        it { should validate_presence_of :title}
        it { should validate_presence_of :description}
        it { should validate_presence_of :thumbnail}
        it { should validate_numericality_of :position}
    end

    describe "existance of object" do
        it "does exist" do
            attrs = {
                title: "How to Add OAuth to Your Rails Apps",
                description: "Learn how to use OAuth.",
                thumbnail: "https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg"
            }

            video = Video.new(attrs)

            expect(video).to be_a Video

            expect(video.title).to eq("How to Add OAuth to Your Rails Apps")
            expect(video.description).to eq("Learn how to use OAuth.")
            expect(video.thumbnail).to eq("https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg")
            expect(video.position).to eq(0)
        end
    end
end