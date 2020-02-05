class UsersController < ApplicationController
  def show
    # conn = Faraday.get(url: "https://api.github.com/users/") do |conn|
    #   conn.token_auth('4ed4bd4ccb1151235aba19f009b4569cffca1d59')
    # end

    # response = Faraday.get("https://api.github.com/users/linda-le1/repos?access_token=4ed4bd4ccb1151235aba19f009b4569cffca1d59")
    github_token = ENV["GITHUB_TOKEN"]
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{github_token}")
    @repos = JSON.parse(response.body)
    # first-repo = repos.first["name"]
    # first-repo = repos.first["html_url"]

    end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
