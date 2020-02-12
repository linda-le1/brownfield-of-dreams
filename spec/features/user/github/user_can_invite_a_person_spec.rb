require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "I can invite a new user to use the app via email" do
    describe "by entering their github username on my dashboard" do
      scenario "if they have an email in github" do
        user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        click_button 'Send an Invite'

        expect(current_path).to eq('/invite')

        fill_in 'Github Handle', with: 'mintona'

        click_button 'Send Invite'

        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content('Successfully sent invite!')
      end

      xscenario "I am alerted if they don't have email in github" do
        user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        click_button 'Send an Invite'

        expect(current_path).to eq('/invite')

        fill_in 'Github Handle', with: 'mintona'

        click_button 'Send Invite'

        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
      end

      xscenario "I am alerted if I enter an invalid github handle" do
        user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        click_button 'Send an Invite'

        expect(current_path).to eq('/invite')

        fill_in 'Github Handle', with: 'nowaythisisagithubuser'

        click_button 'Send Invite'

        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content("There is no Github user with that handle.")
      end
    end
  end
end
