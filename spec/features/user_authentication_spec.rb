require 'rails_helper'

feature 'Create an account' do
  background do
    visit '/'
    click_on 'Sign up'
  end
  scenario "can create a new user via index page" do
    find(:css, "input#user_user_name").set("johnyboy")
    find(:css, "input#user_email").set("john@john.com")
    fill_in 'Password', with: 'SWEETpea/35', match: :first
    fill_in 'Confirm Password', with: 'SWEETpea/35'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  scenario "all fields must be filled to create account" do
    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
  end
end

feature 'Login' do
  background do
    user = create(:user)
    visit '/'
    click_on 'Login'
  end
  scenario 'can log in via index page' do
    fill_in 'Email', with: 'johnb@yahoo.com'
    fill_in 'Password', with: 'SWEETpea/35'
    click_button 'Log in'
    expect(page).to have_content("Signed in successfully")
  end
  scenario 'all fields must be filled to log in' do
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password')
  end
end
