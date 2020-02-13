require 'rails_helper'

RSpec.describe "As a visitor" do
  it "I can see the about page" do
    visit "/about"

    about = "This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel. It's designed for anyone learning how to code, with additional features for current students."
    expect(page).to have_content(about)
  end
end
