require 'rails_helper'

describe 'A registered user' do
    before :each do
        VCR.turn_off!
        WebMock.allow_net_connect!
    end
    it 'can view repos with token' do
        #need repos
        #log the user in

        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#github-repos" do
            expect(page).to have_content("Github Repos")

            #repos 1 - 5 links here
            expect(page).to have_link("Repo One Name Here")
            expect(page).to have_link("Repo Two Name Here")
            expect(page).to have_link("Repo Three Name Here")
            expect(page).to have_link("Repo Four Name Here")
            expect(page).to have_link("Repo Five Name Here")
        end

    end

    xit 'can only repos belonging to logged in user' do
    end

    xit 'cannot see repos without token' do
    end
end