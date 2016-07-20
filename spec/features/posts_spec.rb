require 'rails_helper'

feature "creating posts" do
  background do
    user = create(:user)
    sign_in_with user
  end
  scenario 'logged in user can create a post' do
    expect(page).to have_content("Signed in successfully")
    click_on 'New thread'
    fill_in 'Link', with: "https://armadillo-online.org/facts.html"
    find(:css, ".bootsy_text_area").set("Why can't life be the best for 'em arma'illos!")
    find(:css, "input#post_tag_list").set("armadillo life, great")
    click_button 'Create Post'
    expect(page).to have_content("Your post has been created")
    expect(page).to have_content("Why can't life be the best for 'em arma'illos!")
  end
end

feature 'editing posts' do
  background do
    user = create(:user)
    sign_in_with user
  end
  scenario 'that you created' do
    post = create(:post, tag_list: "how could, this")

    visit '/'
    first(:xpath, "//a[contains(@href,'posts/1')]").click
    find(:css, "a.glyphicon-wrench").click
    find(:css, ".bootsy_text_area").set("Actually, armadillos have it pretty good!")
    click_button 'Update Post'
    expect(page).to have_content("armadillos have it pretty good!")
  end
end

feature 'deleting posts' do
  background do
    user = create(:user)
    sign_in_with user
  end
  scenario 'you created' do
    post = create(:post, tag_list: "how could, this")
    visit '/'
    expect(page).to have_content("how, could, this")
    first(:xpath, "//a[contains(@href,'posts/1')]").click
    find(:css, "a.glyphicon-trash").click
    visit '/'
    expect(page).to_not have_content("how, could, this")
  end
end

feature 'accessing show pages' do
  background do
    user = create(:user)
    sign_in_with user
  end
  scenario 'via link image generated w/ metainspector' do
    post = create(:post, tag_list: "Why me")
    visit '/'
    expect(page).to have_content("Why, me")
    first(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page.current_path).to eq(post_path(post))
  end

end
