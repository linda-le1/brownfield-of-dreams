class GithubSessionsController < ApplicationController
  def create
    current_user.update!(github_token: token, uid: uid)
    redirect_to "/dashboard"
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end

    def token
      auth_hash["credentials"]["token"]
    end

    def uid
      auth_hash["uid"]
    end
end
