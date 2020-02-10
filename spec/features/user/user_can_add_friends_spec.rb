require 'rails_helper'

describe 'A registered user with a token' do
    it 'can add friends who are also users with tokens' do
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
    end
end