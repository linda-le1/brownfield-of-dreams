require "rails_helper"
describe InviteMailer, type: :mailer do
    describe "When a user sends an invite to a non registered user to join the app" do
        before :each do
            @email_address = 'ali@gmail.com'
            @name = 'Alison Vermeil'
            @sender_name = 'Linda'
            @email = InviteMailer.invite_user(@email_address, @name, @sender_name)
        end

        it "has the following subject" do
            expect(@email.subject).to eql("Join Brownfield of Dreams!")
        end

        it "has the correct sender's email address" do
            expect(@email.from).to eql(["no-reply@brownfieldofdreams.com"])
        end

        it "has the correct receiving user's email address" do
            expect(@email.to).to eql(["#{@email_address}"])
        end

        it "has the activation url" do
            expect(@email.body.encoded).to match("/signup")
        end
    end
end
