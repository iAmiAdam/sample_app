require 'spec_helper'

describe "Static pages" do

	# In these tests we visit the page and check it contains the correct content and also has the correct title.
	
	subject { page }

	describe "Home page" do
		before { visit root_path }
     	it { should have_content('Twitter Clone') }
    	it { should have_title( full_title('') ) }
    	# The home page should not read '| Home' in the title, so we test that here.
    	it { should_not have_title(' | Home') }
	end

	describe "Help page" do
		before { visit help_path }
		it { should have_content('Help') }
    	it { should have_title( full_title('Help') ) }
	end

	describe "About page" do
		before { visit about_path }
		it { should have_content('About Us') }
    	it { should have_title( full_title('About Us') ) }
	end

	describe "Contact page" do
		before { visit contact_path }
		it { should have_content('Contact Us') }
		it { should have_title( full_title('Contact Us') ) }	
	end
end