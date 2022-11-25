require 'rails_helper'

RSpec.describe 'Group', type: :feature do
  describe 'New' do
    before(:each) do
      User.destroy_all
      Group.destroy_all

      @user1 = User.new(name: 'ali', password: '1234567', email: 'ali@gmail.com')
      @user1.save

      visit new_user_session_path
      fill_in 'Email', with: 'ali@gmail.com'
      fill_in 'Password', with: '1234567'
      click_button 'Log In'
      click_button 'ADD CATEGORY'
    end

    it 'shoud show the add categories page' do
      expect(page).to have_content('ADD CATEGORY')
    end

    it 'shoud have a name input' do
      expect(assert_selector('input.group-name')).to eq(true)
    end

    it 'shoud have a icon input' do
      expect(assert_selector('input.group-icon')).to eq(true)
    end

    it 'shoud have sign up button' do
      expect(page).to have_button('Save')
    end

    it 'should create a category when credentials are correct' do
      fill_in 'Name', with: 'Dance'
      fill_in 'Icon URL', with: 'test'
      click_button 'Save'

      expect(page).to have_content('Dance')
    end
  end
end
