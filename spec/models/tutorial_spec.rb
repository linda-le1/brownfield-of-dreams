require 'rails_helper'

RSpec.describe Tutorial, type: :model do
    describe "validations" do
        it { should validate_presence_of :title }
        it { should validate_presence_of :description }
        it { should validate_presence_of :thumbnail }
    end

    describe "existance of object" do
        it "does exist" do
            attrs = {
                title: "How to Work on Brownfield Projects",
                description: "Best tutorial ever!",
                thumbnail: "https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg"
            }

            tutorial = Tutorial.new(attrs)

            expect(tutorial).to be_a Tutorial

            expect(tutorial.title).to eq("How to Work on Brownfield Projects")
            expect(tutorial.description).to eq("Best tutorial ever!")
            expect(tutorial.thumbnail).to eq("https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg")
        end
    end
end
