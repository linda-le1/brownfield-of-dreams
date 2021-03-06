require 'rails_helper'

describe "As an admin" do
    scenario "can add a tutorial with no video" do
        admin = create(:user, role: :admin)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit "/admin/tutorials/new"

        fill_in :tutorial_title, with: "OAuth Authentication with Github"
        fill_in :tutorial_description, with: "Learn how to implemented OAuth Github Authentication into your Rails app."
        fill_in :tutorial_thumbnail, with: "https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg"

        click_button "Save"

        tutorial = Tutorial.last

        expect(current_path).to eq(tutorial_path(tutorial.id))
        expect(page).to have_content("Successfully created tutorial.")
        expect(page).to have_content("There are no videos in this tutorial at this time.")
    end

    scenario "cannot add a tutorial if bad information is submitted" do
        admin = create(:user, role: :admin)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit "/admin/tutorials/new"

        fill_in :tutorial_title, with: " "
        fill_in :tutorial_description, with: "Learn how to implemented OAuth Github Authentication into your Rails app."
        fill_in :tutorial_thumbnail, with: "https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg"

        click_button "Save"

        expect(page).to have_content("Tutorial was not successfully created.")
        expect(page).to have_content("Title can't be blank")
    end
end
