require 'rails_helper'

RSpec.describe "Tutorials Index Page" do
  before :each do
    @tutorial1 = create(:tutorial, title: "title 1", description: "tutorial 1")
    @tutorial2 = create(:tutorial, title: "title two", description: "secound tutorial", classroom: true)
    @tutorial3 = create(:tutorial, title: "3rd title", description: "different tutorial", classroom: true)
  end

  describe "as a visitor" do
    it "I only see tutorials that are not classroom content" do
      visit tutorials_path

      expect(page).to have_css('.tutorial', count: 1)

      within("#tutorial-#{@tutorial1.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(@tutorial1.title, href: tutorial_path(@tutorial1.id))
        expect(page).to have_content(@tutorial1.description)
      end
      expect(page).to_not have_content(@tutorial2.title)
      expect(page).to_not have_content(@tutorial2.description)

      expect(page).to_not have_content(@tutorial3.title)
      expect(page).to_not have_content(@tutorial3.description)
    end
  end
end
