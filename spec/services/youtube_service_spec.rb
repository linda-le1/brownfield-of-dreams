require 'rails_helper'

describe YoutubeService do
    context "instance methods" do
        context "#video_info" do
            it "returns user video information" do

            video_fixture = File.read('spec/fixtures/youtube_video.json')

            stub_request(:get, "https://www.googleapis.com/youtube/v3/videos").
            to_return(status: 200, body: video_fixture)

            video_json = JSON.parse(video_fixture, symbolize_names: true)

            expect(video_json).to be_a Hash

            video_info = video_json[:items].first[:snippet]

            expect(video_info).to have_key :title
            expect(video_info).to have_key :description
            expect(video_info).to have_key :thumbnails
            end
        end
    end
end

