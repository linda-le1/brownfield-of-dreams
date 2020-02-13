require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#get_reops" do
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

        github_service = GithubService.new(ENV["GITHUB_TOKEN_LINDA"])
        followers = github_service.get_followers

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

    xcontext "#user_exists?" do

    end

    xcontext "#get_user_email" do

    end
  end
end
