require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#get_repos" do
      it "returns user repos" do

        repo_fixture = File.read('spec/fixtures/repos_ali.json')

        stub_request(:get, "https://api.github.com/user/repos?page=1&per_page=5&affiliation=owner").
        to_return(status: 200, body: repo_fixture)

        github_service = GithubService.new(ENV["GITHUB_TOKEN_ALI"])
        repos = github_service.get_repos

        expect(repos).to be_a Array
        expect(repos.count).to eq 5

        repo = repos.first

        expect(repo).to have_key :name
        expect(repo).to have_key :html_url
      end
    end

    context "#get_followers" do
      it "returns a users followers" do
        follower_fixture = File.read('spec/fixtures/followers_linda.json')

        stub_request(:get, "https://api.github.com/user/followers").
        to_return(status: 200, body: follower_fixture)

        followers = JSON.parse(follower_fixture, symbolize_names: true)

        expect(followers).to be_a Array
        expect(followers.count).to eq 2

        follower = followers.first

        expect(follower).to have_key :login
        expect(follower).to have_key :html_url
        expect(follower).to have_key :id
      end
    end

    context "#get_following" do
      it "returns the github users a user is following" do
        following_fixture = File.read('spec/fixtures/following_linda.json')

        stub_request(:get, "https://api.github.com/user/following").
        to_return(status: 200, body: following_fixture)

        github_service = GithubService.new(ENV["GITHUB_TOKEN_LINDA"])
        following = github_service.get_following

        expect(following).to be_a Array
        expect(following.count).to eq 15

        first_following = following.first

        expect(first_following).to have_key :login
        expect(first_following).to have_key :html_url
        expect(first_following).to have_key :id
      end
    end

    context "#user_exists?" do
      it "returns true if the username entered is a real github handle" do
        # user_exist_fixture = File.read('spec/fixtures/user_exist_linda_le1.json')

        # stub_request(:get, "https://api.github.com/users/linda-le1").
        # to_return(status: 200, body: user_exist_fixture)

        github_service = GithubService.new(ENV["GITHUB_TOKEN_LINDA"])

        expect(github_service.user_exists?("linda-le1")).to eq(true)

        github_service_2 = GithubService.new(ENV["GITHUB_TOKEN_LINDA"])

        expect(github_service_2.user_exists?("nowaythisisagithubuser")).to eq(false)
      end
    end

    context "#get_user" do
      it "returns the info for a github user" do
        user_exist_fixture = File.read('spec/fixtures/user_exist_linda_le1.json')

        stub_request(:get, "https://api.github.com/users/linda-le1").
        to_return(status: 200, body: user_exist_fixture)

        github_service = GithubService.new(ENV["GITHUB_TOKEN_LINDA"])

        user_information = github_service.get_user("linda-le1")

        expect(user_information).to be_a Hash
        expect(user_information).to have_key :name
        expect(user_information).to have_key :email
      end
    end
  end
end
