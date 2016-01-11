require 'rails_helper'

feature 'Deleting posts' do

  background do
    user = create :user
    user_two = create(:user, email: 'example@gmail.com',
                          user_name:'exampleme', 
                          password: 'thepassword',
                          id: user.id + 1)
    post = create(:post, caption: 'Abs for days.', user_id: user.id)
    post_two = create(:post, user_id: user.id + 1)

    sign_in_with user
  end

  scenario 'Can delete a single post as the owner' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Delete Post'

    expect(page).to have_content('Problem solved!  Post deleted.')
    expect(page).to_not have_content('Abs for days.')
  end

  scenario 'Can not delete a post that does not belong to use via the show page' do
    find(:xpath, "//a[contains(@href,'posts/2')]").click
    expect(page).to_not have_content('Delete Post')
  end
end
