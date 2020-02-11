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

        within(".friends") do
          expect(page).to_not have_content("mintona")
          expect(page).to have_content("You haven't added any friends yet!")
        end

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

        within(".friends") do
          expect(page).to_not have_content("mintona")
        end

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

      it "notifies user if already friends with person they are trying to add" do
        following_fixture = File.read('spec/fixtures/following_linda.json')

        stub_request(:get, "https://api.github.com/user/following").
        to_return(status: 200, body: following_fixture)

        linda = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"], uid: 54052410)
        ali = create(:user, github_token: ENV["GITHUB_TOKEN_ALI"], uid: 51250305)


        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(linda)

        visit '/dashboard'

        within(".friends") do
          expect(page).to_not have_content("mintona")
        end

        within("#following-mintona") do
          expect(page).to have_link("mintona")
          expect(page).to have_button("Add as Friend")
          click_on("Add as Friend")
        end

        within(".friends") do
          expect(page).to have_content("mintona")
        end

        within("#following-mintona") do
          click_on("Add as Friend")
        end

        expect(page).to have_content("You have already added this friend!")
        expect(current_path).to eq("/dashboard")
      end
  end
end
