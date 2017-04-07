require 'rails_helper'

describe "Signing in" do

  it "prompts for a username and password" do
    visit root_url

    click_link 'Sign In'

    expect(current_path).to eq(signin_path)

    expect(page).to have_field("Username")
    expect(page).to have_field("Password")
  end

	it "signs in the user if the username/password combination is valid" do
	  user = User.create!(user_attributes)

	  visit root_url

	  click_link 'Sign In'

	  fill_in "Username", with: user.username
	  fill_in "Password", with: user.password

	  click_button 'Sign In'

	  expect(current_path).to eq(user_path(user))   

	  expect(page).to have_text("Welcome back, #{user.name}!")
	  expect(page).to have_link(user.username)
	  expect(page).to have_link('Sign Out')
  	expect(page).not_to have_link('Sign In')
  	expect(page).not_to have_link('Sign Up')
	end

	it "does not sign in the user if the username/password combination is invalid" do
	  user = User.create!(user_attributes)

	  visit root_url

	  click_link 'Sign In'

	  fill_in "Username", with: user.username
	  fill_in "Password", with: "no match"

	  click_button 'Sign In'

	  expect(page).to have_text('Invalid')
	  expect(page).not_to have_link(user.username)
  	expect(page).to have_link('Sign In')
  	expect(page).not_to have_link('Sign Out')
  	expect(page).to have_link('Sign Up')
	end

	it "redirects to the intended page" do
	  user = User.create!(user_attributes)

	  visit users_url

	  expect(current_path).to eq(new_session_path)

	  sign_in(user)

	  expect(current_path).to eq(users_path)
	end
end