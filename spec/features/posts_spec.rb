require 'rails_helper'

feature "creating posts" do
  background do
    user = create(:user)
    sign_in_with user
  end
  scenario 'logged in user can create a post' do
    expect(page).to have_content("Signed in successfully")
    click_on 'New post'
    fill_in 'Link', with: "https://armadillo-online.org/facts.html"
    fill_in 'Title', with: "I love armadillos"
    fill_in 'Add your full commentary here:', with: "Why can't armadillos and people unite for a common cause?"
    click_button 'Create Post'
    expect(page).to have_content("Your post has been created")
    expect(page).to have_content("love armadillos")
    expect(page).to have_content("Why can't armadillos and people")
  end
end

feature 'editing posts' do
  background do
    user = create(:user)
    sign_in_with user
  end
  scenario 'that you created' do
    post = create(:post, commentary: "Why me")
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_on 'Edit'
    fill_in 'Title', with: "I made a mistake"
    fill_in 'Add your full commentary here:', with: "Wait, no I didn't.."
    click_button 'Update Post'
    expect(page).to have_content("successfully updated")
    click_on 'Back'
    expect(page).to have_content("made a mistake")
    expect(page).to have_content("Wait, no")
  end
end

feature 'deleting posts' do
  background do
    user = create(:user)
    sign_in_with user
  end
  scenario 'you created' do
    post = create(:post, commentary:"Type type")
    visit '/'
    expect(page).to have_content("Type type")
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_on 'Delete'
    visit '/'
    expect(page).to_not have_content("Type type")
  end
end

feature 'accessing show pages' do
  background do
    user = create(:user)
    sign_in_with user
  end
  scenario 'via link image generated w/ metainspector' do
    post = create(:post, commentary: "Why me")
    visit '/'
    expect(page).to have_content("Why me")
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page.current_path).to eq(post_path(post))
  end

end
