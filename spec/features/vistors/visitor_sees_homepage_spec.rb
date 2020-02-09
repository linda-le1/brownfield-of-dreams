require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within("#tutorial-#{tutorial1.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(tutorial1.title, href: tutorial_path(tutorial1.id))
        expect(page).to have_content(tutorial1.description)
      end

      within("#tutorial-#{tutorial2.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(tutorial2.title, href: tutorial_path(tutorial2.id))
        expect(page).to have_content(tutorial2.description)
      end
    end

    it "does not see tutorials marked as 'classroom content'" do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial, classroom: true)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 1)

      within('.tutorials') do
        expect(page).to have_css("#tutorial-#{tutorial1.id}")
        expect(page).to have_link(tutorial1.title, href: tutorial_path(tutorial1.id))
        expect(page).to have_content(tutorial1.description)
        expect(page).to_not have_css("#tutorial-#{tutorial2.id}")
        expect(page).to_not have_link(tutorial2.title, href: tutorial_path(tutorial2.id))
        expect(page).to_not have_content(tutorial2.description)
      end
    end
  end
end
