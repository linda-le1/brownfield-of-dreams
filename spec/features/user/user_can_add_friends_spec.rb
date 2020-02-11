require 'rails_helper'

describe 'A registered user with a token' do
    describe 'can add friends who are also users of our app with tokens' do

      it "by clicking on the add friend button of follower" do

        followers_fixture = File.read('spec/fixtures/followers_linda.json')

        stub_request(:get, "https://api.github.com/user/followers").
        to_return(status: 200, body: followers_fixture)

        linda = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"], uid: 54052410)
        ali = create(:user, github_token: ENV["GITHUB_TOKEN_ALI"], uid: 51250305)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(linda)

        visit '/dashboard'

        within("#github-followers") do
          within("#follower-danmoran-pro") do
            expect(page).to have_link("danmoran-pro")
            expect(page).to_not have_button("Add as Friend")
          end

          within("#follower-mintona") do
            expect(page).to have_link("mintona")
            expect(page).to have_button("Add as Friend")
            click_on("Add as Friend")
          end
        end

        expect(page).to have_content("You have added a friend!")
        expect(current_path).to eq("/dashboard")
        expect(page).to have_css(".friends")
        within(".friends") do
          expect(page).to have_content("mintona")
        end
      end

      it "by clicking on the add friend button of following" do
        following_fixture = File.read('spec/fixtures/following_linda.json')

        stub_request(:get, "https://api.github.com/user/following").
        to_return(status: 200, body: following_fixture)

        linda = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"], uid: 54052410)
        ali = create(:user, github_token: ENV["GITHUB_TOKEN_ALI"], uid: 51250305)


        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(linda)

        visit '/dashboard'

        within("#github-following") do
          within("#following-presidentbeef") do
            expect(page).to have_link("presidentbeef")
            expect(page).to_not have_button("Add as Friend")
          end


          within("#following-mintona") do
            expect(page).to have_link("mintona")
            expect(page).to have_button("Add as Friend")
            click_on("Add as Friend")
          end
        end

        expect(page).to have_content("You have added a friend!")
        expect(current_path).to eq("/dashboard")
        expect(page).to have_css(".friends")
        
        within(".friends") do
          expect(page).to have_content("mintona")
        end
      end

  end
end

# linda with a token is our logged in user
# this person needs 2 followers on github
# mintona with a token is 1 follower
# danmoran-pro does not have an account with our app
# if a follower has an account in our app, a link to add them as a friend should appear
# if our current user has a following who also has an acct, then the link should also appear

# mintona has a Add as Friend link
# danmoran-pro does not have this link

# mintona is following linda and is a registered user and also needs a link
# linda is following presidentbeef and is not a user so no link

#section on dashboard of all users that linda has friended
#friendship should not go through if id invalid (see story)
