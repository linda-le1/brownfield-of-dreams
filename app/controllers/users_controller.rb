class UsersController < ApplicationController
  def show
    # could probably be some sort of.. if current_user.github_token?
      # github_token = current_user.github_token
      conn = Faraday.new(url: "https://api.github.com/")
      github_token = ENV["GITHUB_TOKEN"] # variable above would replace this
      conn.basic_auth(nil, github_token)

      response = conn.get("/user/repos")
      repos = JSON.parse(response.body)
      # right now we get back repos that this person is a contributor on,
      # not just an owner of
      @repos = repos.map do |repo|
        Repository.new(repo)
      end
    # else
      #do nothing?
    #end
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
