require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  describe 'relationships' do
    it { should belong_to :video }
    it { should belong_to :user}
  end

  describe 'attributes' do
    it 'has attributes' do
      user = create(:user)
      video = create(:video)
      user_video = create(:user_video, user: user, video: video)

      expect(user_video).to be_a UserVideo
      expect(user_video.user_id).to eq(user.id)
      expect(user_video.video_id).to eq(video.id)
    end
  end

  describe 'model methods' do
    describe '#video_titles' do
      it 'returns the titles, video_id and tutorial_id of the bookmarks for the given user sorted by tutorial then video position' do

        user = create(:user)

        tutorial_1 = create(:tutorial, title: "Z Tutorial")
        video_1 = create(:video, title: "First and only, but very last.", tutorial_id: tutorial_1.id, position: 1)
        UserVideo.create!(user: user, video: video_1)

        tutorial_2 = create(:tutorial, title: "A Tutorial")
        video_2a = create(:video, title: "A first", tutorial_id: tutorial_2.id, position: 0)
        video_2b = create(:video, title: "A second", tutorial_id: tutorial_2.id, position: 1)
        UserVideo.create!(user: user, video: video_2a)
        UserVideo.create!(user: user, video: video_2b)

        tutorial_3 = create(:tutorial)
        video_3 = create(:video, tutorial_id: tutorial_3.id)

        tutorial_4 = create(:tutorial, title: "M Tutorial")
        video_4a = create(:video, title: "M second", tutorial_id: tutorial_4.id, position: 1)
        UserVideo.create!(user: user, video: video_4a)
        video_4b = create(:video, title: "M third", tutorial_id: tutorial_4.id, position: 2)
        UserVideo.create!(user: user, video: video_4b)
        video_4c = create(:video, title: "M first", tutorial_id: tutorial_4.id, position: 0)
        UserVideo.create!(user: user, video: video_4c)

        # expected = [video_2a.title, video_2b.title, video_4c.title, video_4a.title, video_4b.title, video_1.title]
        expected = [video_2a, video_2b, video_4c, video_4a, video_4b, video_1]
        bookmark_1 = UserVideo.video_titles(user.id).first
        bookmark_2 = UserVideo.video_titles(user.id).second
        bookmark_3 = UserVideo.video_titles(user.id).third
        bookmark_4 = UserVideo.video_titles(user.id).fourth
        bookmark_5 = UserVideo.video_titles(user.id).fifth
        bookmark_6 = UserVideo.video_titles(user.id).last

        expect(bookmark_1.title).to eq(video_2a.title)
        expect(bookmark_1.video_id).to eq(video_2a.id)
        expect(bookmark_1.tutorial_id).to eq(tutorial_2.id)

        expect(bookmark_2.title).to eq(video_2b.title)
        expect(bookmark_2.video_id).to eq(video_2b.id)
        expect(bookmark_2.tutorial_id).to eq(tutorial_2.id)

        expect(bookmark_3.title).to eq(video_4c.title)
        expect(bookmark_3.video_id).to eq(video_4c.id)
        expect(bookmark_3.tutorial_id).to eq(tutorial_4.id)

        expect(bookmark_4.title).to eq(video_4a.title)
        expect(bookmark_4.video_id).to eq(video_4a.id)
        expect(bookmark_4.tutorial_id).to eq(tutorial_4.id)

        expect(bookmark_5.title).to eq(video_4b.title)
        expect(bookmark_5.video_id).to eq(video_4b.id)
        expect(bookmark_5.tutorial_id).to eq(tutorial_4.id)

        expect(bookmark_6.title).to eq(video_1.title)
        expect(bookmark_6.video_id).to eq(video_1.id)
        expect(bookmark_6.tutorial_id).to eq(tutorial_1.id)
      end
    end
  end
end
