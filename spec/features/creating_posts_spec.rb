require 'rails_helper.rb'

feature 'Creating posts' do
  background do
    user = create :user
    sign_in_with user
  end
  scenario 'can create a new post' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'nom nom nom #coffeetime'
    click_button 'Create Post'
    expect(page).to have_content('#coffeetime')
    expect(page).to have_css("img[src*='coffee.jpg']")
    expect(page).to have_content('Arnie')
  end

  it 'needs an image to create a post' do
    visit '/'
    click_link 'New Post'
    fill_in 'Caption', with: 'No picture because YOLO'
    click_button 'Create Post'
    expect(page).to have_content('Something went wrong with your submission')
  end

  it 'caption must not be too short' do
    visit '/'
    click_link 'New Post'
    fill_in 'Caption', with: 'hi'
    attach_file('Image', "spec/files/images/coffee.jpg")
    click_button 'Create Post'
    expect(page).to have_content('Something went wrong with your submission')
  end

  it 'caption must not be too long' do
    visit '/'
    click_link 'New Post'
    fill_in 'Caption', with: 'a' * 301
    attach_file('Image', "spec/files/images/coffee.jpg")
    click_button 'Create Post'
    expect(page).to have_content('Something went wrong with your submission')
  end
end
