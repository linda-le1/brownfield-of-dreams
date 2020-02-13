class InviteController < ApplicationController
  def new; end

  def create
    service = GithubService.new(current_user.github_token)

    if !service.user_exists?(params[:github_handle])
      flash[:error] = 'There is no Github user with that handle.'
      render :new
    else
      invitee = service.get_user(params[:github_handle])
      attempt_to_send_email(invitee)
    end
  end

  private

  def send_invite_email(invitee_email, invitee_name, sender_name)
    InviteMailer.invite_user(invitee_email, invitee_name, sender_name).deliver_now
    flash[:success] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end

  def send_email_if_new_user(invitee)
    if User.exists?(uid: invitee[:id])
      flash[:error] = 'The Github user already has an account with Brownfield of Dreams.'
      render :new
    else
      send_invite_email(invitee[:email], invitee[:name], current_user.full_name)
    end
  end

  def attempt_to_send_email(invitee)
    if invitee[:email].nil?
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      render :new
    else
      send_email_if_new_user(invitee)
    end
  end
end
