require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe "validations" do
    it { should have_many :videos }
    #should there be more assertions here for the
    #taggable and nested_attributes?
  end

  describe "model methods" do
    describe "#not_classroom_content" do
      it "displays only tutorials where classroom attribute is false" do
        create_list(:tutorial, 4)
        tutorial5 = create(:tutorial, classroom: true)

        result = Tutorial.not_classroom_content

        expect(result.length).to eq(4)
        expect(result.include?(tutorial5)).to eq(false)
      end
    end
  end
end
