require 'rails_helper'

feature 'viewing individual posts' do
  background do
    user = create :user
    post = create(:post, user_id: user.id)

    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
  scenario 'can click and view a single post from the index' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page.current_path).to eq(post_path(1))
  end
end
