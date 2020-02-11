require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it "can see a list of bookmarks on the dashboard grouped by tutorial and ordered by position" do
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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within(".bookmarks") do
      expect(page).to have_content("Bookmarked Segments")
      expect(page).to have_css(".bookmark", count: 6)
      expect(page).to_not have_content(video_3.title)
    end
### do you think these should be links to the videos? why else would they be bookmarked?
    within("#bookmark-0") do
      expect(page).to have_content(video_2a.title)
    end

    within("#bookmark-1") do
      expect(page).to have_content(video_2b.title)
    end

    within("#bookmark-2") do
      expect(page).to have_content(video_4c.title)
    end

    within("#bookmark-3") do
      expect(page).to have_content(video_4a.title)
    end

    within("#bookmark-4") do
      expect(page).to have_content(video_4b.title)
    end

    within("#bookmark-5") do
      expect(page).to have_content(video_1.title)
    end
  end
  # Check sad path up there about not being able to book mark twice
  
#   As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position

  # add test for when there are no bookmarks
end
