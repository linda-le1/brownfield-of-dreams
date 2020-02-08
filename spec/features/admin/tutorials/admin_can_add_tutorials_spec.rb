require 'rails_helper'

describe "As an admin" do
    scenario "can add a tutorial" do
        admin = create(:user, role: :admin)

        visit new_admin_tutorial_path

        fill_in :title, with: "OAuth Authentication with Github"
        fill_in :description, with: "Learn how to implemented OAuth Github Authentication into your Rails app."
        fill_in :thumbnail, with: "https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg"

        click_button "Save"

        expect(current_path).to eq(tutorial_path)
        expect(page).to have_content("Successfully created tutorial.")
    end
end
