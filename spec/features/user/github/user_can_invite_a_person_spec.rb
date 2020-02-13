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

        fill_in :github_handle, with: 'mintona'

        expect do
          click_button 'Send Invite'
        end.
        to change { ActionMailer::Base.deliveries.count }.by(1)

        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content('Successfully sent invite!')
      end

      scenario "I am alerted if they don't have email in github" do
        user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        click_button 'Send an Invite'

        expect(current_path).to eq('/invite')

        fill_in :github_handle, with: 'danmoran-pro'

        click_button 'Send Invite'

        expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
        expect(page).to have_button 'Send Invite'
      end

      scenario "I am alerted if I enter an invalid github handle" do
        user = create(:user, github_token: ENV["GITHUB_TOKEN_LINDA"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        click_button 'Send an Invite'

        expect(current_path).to eq('/invite')

        fill_in :github_handle, with: 'nowaythisisagithubuser'

        click_button 'Send Invite'

        expect(page).to have_content("There is no Github user with that handle.")
        expect(page).to have_button 'Send Invite'
      end
    end
  end

  describe "As the invitee" do
    describe "when I click the link from the email invite" do
      scenario "I am taken to a signup page" do
        visit "/signup"

        expect(page).to have_content('Register')
        expect(page).to have_content('Email')
        expect(page).to have_content('First name')
        expect(page).to have_content('Last name')
        expect(page).to have_content('Password')
        expect(page).to have_button('Create Account')
      end
    end
  end
end
