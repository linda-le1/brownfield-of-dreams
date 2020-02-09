require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "when I visit the homepage" do
    it "I see tutorials of any classroom status" do
      user = create(:user)
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial, classroom: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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
  end
end
