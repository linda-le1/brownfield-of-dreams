require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    before :each do
      @tutorial1 = create(:tutorial, title: "First Tutorial", description: "First one!")
      @tutorial2 = create(:tutorial, title: "Second Tutorial", description: "Second one!")

      video1 = create(:video, tutorial_id: @tutorial1.id)
      video2 = create(:video, tutorial_id: @tutorial1.id)
      video3 = create(:video, tutorial_id: @tutorial2.id)
      video4 = create(:video, tutorial_id: @tutorial2.id)
    end

    it 'can see a list of tutorials' do
      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within("#tutorial-#{@tutorial1.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(@tutorial1.title, href: tutorial_path(@tutorial1.id))
        expect(page).to have_content(@tutorial1.description)
      end

      within("#tutorial-#{@tutorial2.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(@tutorial2.title, href: tutorial_path(@tutorial2.id))
        expect(page).to have_content(@tutorial2.description)
      end
    end

    it "does not see tutorials marked as 'classroom content'" do
      tutorial3 = create(:tutorial, title: "Tutorial 3", description: "For the classroom", classroom: true)
      tutorial4 = create(:tutorial, title: "Fourth tutorial", description: "Classroom use only", classroom: true)

      visit root_path

      expect(Tutorial.count).to eq(4)

      expect(page).to have_css('.tutorial', count: 2)

      within('.tutorials') do
        expect(page).to have_content(@tutorial1.title)
        expect(page).to have_content(@tutorial2.title)

        expect(page).to_not have_css("#tutorial-#{tutorial3.id}")
        expect(page).to_not have_link(tutorial3.title, href: tutorial_path(tutorial3.id))
        expect(page).to_not have_content(tutorial3.description)

        expect(page).to_not have_css("#tutorial-#{tutorial4.id}")
        expect(page).to_not have_link(tutorial4.title, href: tutorial_path(tutorial4.id))
        expect(page).to_not have_content(tutorial4.description)
      end
    end
  end
end
