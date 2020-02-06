require 'rails_helper'

describe 'A registered user' do
    scenario 'can view repos with token' do
        repo_fixture = File.read('spec/fixtures/repos.json')

        stub_request(:get, "https://api.github.com/user/repos?page=1&per_page=5").
        to_return(status: 200, body: repo_fixture)

        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#github-repos" do
            expect(page).to have_content("Github Repos")
            expect(page).to have_link("monster_shop_part_1")
            expect(page).to have_link("activerecord-obstacle-course")
            expect(page).to have_link("adopt_dont_shop")
            expect(page).to have_link("adopt_dont_shop_part_two")
            expect(page).to have_link("futbol")
        end
    end

    scenario 'can only repos belonging to logged in user' do
      repo_fixture = File.read('spec/fixtures/repos.json')

      stub_request(:get, "https://api.github.com/user/repos?page=1&per_page=5").
      to_return(status: 200, body: repo_fixture)

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within "#github-repos" do
          expect(page).to have_content("Github Repos")
          expect(page).to have_link("monster_shop_part_1")
          expect(page).to have_link("activerecord-obstacle-course")
          expect(page).to have_link("adopt_dont_shop")
          expect(page).to have_link("adopt_dont_shop_part_two")
          expect(page).to have_link("futbol")
      end
    end

    xit 'cannot see repos without token' do
      # user = create(:github_token = "")
      # i think that we need to add a column to the model before we can
      # really start testing other users

      # need to get out the hard coded token for this test
      # would you stub this out?
      # allow ENV["GITHUB_TOKEN"]. to eq("")
    end
end

#create seeds using figaro, 2 users: one with linda, one with mine
#testing : 1 user w/ a correct token and one without
