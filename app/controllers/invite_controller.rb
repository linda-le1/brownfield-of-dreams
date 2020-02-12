class InviteController < ApplicationController
  def new
  end

  def create
    # response comes back as "404 Not Found" if the username isn't a real github name
    service = GithubService.new(current_user.github_token)

  end
end
