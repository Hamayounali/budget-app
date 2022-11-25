require 'rails_helper'

RSpec.describe 'Login page', type: :feature do
  describe 'Visiting the login page' do
    before(:each) do
      User.destroy_all
      User.create(name: 'ali', email: 'ali@gmail.com', password: '1234567')

      visit new_user_session_path
    end

    it 'shoud have an email' do
      expect(assert_selector('input.session-email')).to eq(true)
    end

    it 'shoud have a password' do
      expect(assert_selector('input.session-password')).to eq(true)
    end

    it 'shoud have a login button' do
      expect(page).to have_button('Log In')
    end

    it 'should authenticate user when credentials are correct' do
      fill_in 'Email', with: 'ali@gmail.com'
      fill_in 'Password', with: '1234567'
      click_button 'Log In'

      expect(page.current_path).to eq(user_path)
    end
  end
end
