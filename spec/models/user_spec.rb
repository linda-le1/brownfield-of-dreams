require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:password)}
    it {should allow_value(nil).for(:uid)}
  end

  describe 'attributes' do
    it "has attributes" do
      user = User.create!(first_name: "First",
                          last_name: "Last",
                          email: "email@email.com",
                          password: "password",
                          github_token: "mytoken",
                          uid: 123456)

      expect(user.first_name).to eq("First")
      expect(user.last_name).to eq("Last")
      expect(user.email).to eq("email@email.com")
      expect(user.github_token).to eq("mytoken")
      expect(user.uid).to eq(123456)
    end
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'model methods' do
    describe '#status' do
      it 'displays the status of the user' do
        user_1 = create(:user)
        user_2 = create(:user, active?: true)

        expect(user_1.status).to eq("Inactive")
        expect(user_2.status).to eq("Active")
      end
    end

    describe '#full_name' do
      it 'displays the first and last name of the user' do
        user = create(:user, first_name: "Ali", last_name: "Smith")

        expect(user.full_name).to eq("Ali Smith")
      end
    end
  end
end
