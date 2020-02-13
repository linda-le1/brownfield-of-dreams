class InviteMailer < ApplicationMailer
  def invite_user(email, name, sender_name)
    @sender_name = sender_name
    @invitee_name = name
    mail(to: email, subject: "Join Brownfield of Dreams!")
  end
end
