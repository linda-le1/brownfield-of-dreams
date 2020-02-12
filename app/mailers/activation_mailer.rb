class ActivationMailer < ApplicationMailer
    def send_activation_email(user)
        @user = user
        mail(to: user.email, subject: "Activate Your Account")
    end
end