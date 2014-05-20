require 'spec_helper'

describe "Home page" do
    it "should have Twitter clone in the h1" do
		visit '/static_pages/home'
     	expect(page).to have_content("Twitter Clone")
    end
end

describe "Help page" do
	it "should have the content 'Help'" do
		visit '/static_pages/help'
		expect(page).to have_content('Help')
	end
end
