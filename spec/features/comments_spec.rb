require 'rails_helper'

feature "create/delete comments" do
  scenario 'can comment on existing post' do
    user = create(:user)
    sign_in_with user
    post = create(:post, user_id: user.id)
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    fill_in 'Add your commentary:', with: 'welcome to tijuana!'
    click_on 'Create Comment'
    expect(page).to have_css('div.comments', text: 'tijuana')
    expect(page).to have_css('.glyphicon-remove')
    page.find('.glyphicon-remove').click
    expect(page).to_not have_content('tijuana')

  end
end

