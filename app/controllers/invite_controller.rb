class InviteController < ApplicationController
  def new; end

  def create
    service = GithubService.new(current_user.github_token)

    handle = params[:github_handle]

    if service.user_exists?(handle)
      invitee = service.get_user(handle)
      invitee_email = invitee[:email]
      invitee_name = invitee[:name]
      if invitee_email.nil?
        flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
        render :new
      else

        InviteMailer.invite_user(invitee_email, invitee_name, current_user.first_name).deliver_now
        flash[:success] = 'Successfully sent invite!'

        redirect_to dashboard_path
      end
    else
      flash[:error] = 'There is no Github user with that handle.'
      render :new
    end
  end
end
