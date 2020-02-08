require 'rails_helper'

describe "As an admin" do
    scenario "can add a tutorial" do
        admin = create(:user, role: :admin)
    end
end


# When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."