require 'rails_helper'

feature 'Editing posts' do
  background do
    user = create :user
    user_two = create(:user, email: 'example@gmail.com',
                            user_name: 'ExampleMe',
                            id: user.id + 1)
    post = create(:post, user_id: user.id)
    post_two = create(:post, user_id: user.id + 1)

    sign_in_with user
    visit'/'
  end

  scenario 'Can edit a post as the owner' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page).to have_content('Edit Post')

    click_link 'Edit Post'
    fill_in 'Caption', with: "Oh god, you weren't meant to see this picture!"
    click_button 'Update Post'

    expect(page).to have_content("Post updated hombre")
    expect(page).to have_content("Oh god, you weren't meant to see this picture!")
  end

  scenario "cannot edit a post that dosen't belong to you via the show page" do
    find(:xpath, "//a[contains(@href,'posts/2')]").click
    expect(page).to_not have_content('Edit Post')
  end

  scenario "cannot edit a post that dosen't belong to you via the url path" do
    visit "/posts/2/edit"
    expect(page.current_path).to eq root_path
    expect(page).to have_content("That doesn't belong to you!")
  end

  scenario "a post won't update a post without an image" do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit Post'
    attach_file('Image', "spec/files/images/example.zip")
    click_button 'Update Post'

    expect(page).to have_content("Something is wrong with you form!")
  end
end
