class UsersController < ApplicationController
  def show
    if current_user.github_token?
      render locals: {
        user_github_search: UserGithubSearch.new(current_user.github_token)
      }
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.first_name}."
      flash[:notice] = "This account has not yet been activated. Please check your email."

      redirect_to dashboard_path
    else
      @user = User.new
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
