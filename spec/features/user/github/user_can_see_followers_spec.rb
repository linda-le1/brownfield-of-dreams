require 'rails_helper'

describe 'A logged in user' do
    scenario 'can view a list of their followers in the dashboard' do
        followers_fixture = File.read('spec/fixtures/followers_linda.json')

        stub_request(:get, "https://api.github.com/user/followers").
        to_return(status: 200, body: followers_fixture)

        user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#github-followers" do
            expect(page).to have_css(".follower", count: 2)
            expect(page).to have_content("Github Followers")
            expect(page).to have_link("danmoran-pro", href:"https://github.com/danmoran-pro")
            expect(page).to have_link("mintona", href:"https://github.com/mintona")
        end
    end

    scenario 'can only view a list of followers for the logged in user' do
        followers_fixture = File.read('spec/fixtures/followers_ali.json')

        stub_request(:get, "https://api.github.com/user/followers").
        to_return(status: 200, body: followers_fixture)

        user = create(:user, github_token: ENV["GITHUB_TOKEN_ALI"])
        user_2 = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])
        user_2_followers = JSON.parse(File.read('spec/fixtures/followers_linda.json'))

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#github-followers" do
            expect(page).to have_css(".follower", count: 1)
            expect(page).to have_content("Github Followers")
            expect(page).to have_link("linda-le1", href:"https://github.com/linda-le1")
            user_2_followers.each do |follower|
              expect(page).to_not have_link(nil, href: follower["html_url"])
            end
        end
    end

    scenario 'user will be notified if they have no followers' do
      followers_fixture = File.read('spec/fixtures/followers_none.json')

      stub_request(:get, "https://api.github.com/user/followers").
      to_return(status: 200, body: followers_fixture)

      user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

          within "#github-followers" do
            expect(page).not_to have_css(".follower")
            expect(page).to have_content("Github Followers")
            expect(page).not_to have_content("You have no followers.")
          end
      end

    scenario 'cannot view a list of their followers in the dashboard if no token' do
      user = create(:user, github_token: nil)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

          expect(page).not_to have_css(".follower")
          expect(page).not_to have_content("Github Followers")
      end
    end
