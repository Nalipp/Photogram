require 'rails_helper'

  feature 'Deleting comments' do
    background do
      user = create :user
      user_two = create(:user, email: "example@gmail.com",
                          user_name: "example",
                          password: "mypassword",
                          id: 2)
      post = create(:post)
      comment = create(:comment, content: "Nice post!", user_id: user_two.id, post_id: post.id)
      sign_in_with user_two
    end

    scenario 'user can delete their own comments' do
      visit '/'
      expect(page).to have_content('Nice post!')
      click_link 'delete-1'
      expect(page).to_not have_content("Nice post!")
    end
  end
