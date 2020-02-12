require 'rails_helper'

describe 'A logged in user' do
    scenario 'can view a list of who they follow in the dashboard' do
        following_fixture = File.read('spec/fixtures/following_linda.json')

        stub_request(:get, "https://api.github.com/user/following").
        to_return(status: 200, body: following_fixture)

        following_parsed = JSON.parse(following_fixture)

        user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#github-following" do
            expect(page).to have_css(".following", count: 15)
            expect(page).to have_content("Following on Github")
            following_parsed.each do |following|
              expect(page).to have_link(following["login"], href: following["html_url"])
            end
        end
    end

    scenario 'can only view a list of who the logged in user is following' do
        following_fixture = File.read('spec/fixtures/following_ali.json')

        stub_request(:get, "https://api.github.com/user/following").
        to_return(status: 200, body: following_fixture)

        user = create(:user, github_token: ENV["GITHUB_TOKEN_ALI"])
        user_2 = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])
        user_2_following = JSON.parse(File.read('spec/fixtures/following_linda.json'))

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#github-following" do
            expect(page).to have_css(".following", count: 2)
            expect(page).to have_content("Following on Github")
            expect(page).to have_link("linda-le1", href:"https://github.com/linda-le1")
            expect(page).to have_link("mel-rob", href:"https://github.com/mel-rob")
            user_2_following.each do |following|
              expect(page).to_not have_link(nil, href: following["html_url"])
            end
        end
    end

    scenario 'user will be notified if they are not following anyone' do
      following_fixture = File.read('spec/fixtures/following_none.json')

      stub_request(:get, "https://api.github.com/user/following").
      to_return(status: 200, body: following_fixture)

      user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

          within "#github-following" do
            expect(page).not_to have_css(".following")
            expect(page).to have_content("Following on Github")
            expect(page).to have_content("You are not following anyone.")
          end
      end

    scenario 'cannot view a list of who they are following in the dashboard if no token' do

        user = create(:user, github_token: nil)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

            expect(page).not_to have_css(".following")
            expect(page).not_to have_content("Following on Github")
        end
    end
