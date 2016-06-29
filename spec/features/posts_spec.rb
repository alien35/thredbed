require 'rails_helper'

feature "creating posts" do
  background do
    user = create(:user)
  end
  scenario 'logged in user can create a post' do
    sign_in_with user
    expect(page).to have_content("Signed in successfully")
    click_on 'New post'
    fill_in 'Link', with: "https://armadillo-online.org/facts.html"
    fill_in 'Title', with: "I love armadillos"
    fill_in 'Commentary', with: "Why can't armadillos and people unite for a common cause?"
    click_button 'Submit'
    expect(view).to render_template(:index)
    expect(page).to have_content("Post successfully created")
    expect(page).to have_content("love armadillos")
    expect(page).to have_content("Why can't armadillos and people")


  end

end
