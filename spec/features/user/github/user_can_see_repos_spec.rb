require 'rails_helper'

describe 'A registered user' do
    scenario 'can view repos with token', :vcr do
        #need repos
        #log the user in

        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#github-repos" do
            expect(page).to have_content("Github Repos")

            #repos 1 - 5 links here
            # is order important?
            expect(page).to have_link("monster_shop_part_1")
            expect(page).to have_link("activerecord-obstacle-course")
            expect(page).to have_link("adopt_dont_shop")
            expect(page).to have_link("adopt_dont_shop_part_two")
            expect(page).to have_link("futbol")
        end

    end

    xit 'can only repos belonging to logged in user' do
      repo_1 = Repo.new("Not my repo", "not my repo URL")
      repo_2 = Repo.new("Not my repo either", "not my repo URL")
      repo_3 = Repo.new("Nor this one", "not my repo URL")

      #expect that you don't see any of these repos listed??
      #does that even make sense?
    end

    xit 'cannot see repos without token' do
      # i think that we need to add a column to the model before we can
      # really start testing other users
    end
end
