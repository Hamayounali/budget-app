require 'rails_helper'

RSpec.describe 'Deal', type: :feature do
  describe 'New' do
    before(:each) do
      User.destroy_all
      Group.destroy_all
      Deal.destroy_all
      GroupDeal.destroy_all

      @user1 = User.new(name: 'Ali', password: '1234567', email: 'ali@gmail.com')
      @user1.save

      @group1 = @user1.groups.new(id: 43, name: 'Electronics', icon: 'test')
      @group1.save

      @group2 = @user1.groups.new(id: 44, name: 'Sport', icon: 'test')
      @group2.save

      visit new_user_session_path
      fill_in 'Email', with: 'ali@gmail.com'
      fill_in 'Password', with: '1234567'
      click_button 'Log In'
      click_on 'Electronics'
      click_button 'ADD TRANSACTION'
    end

    it 'shoud show the add transactions page' do
      expect(page).to have_content('ADD TRANSACTION')
    end

    it 'shoud have a name input' do
      expect(assert_selector('input.deal-name')).to eq(true)
    end

    it 'shoud have a amount input' do
      expect(assert_selector('input.deal-amount')).to eq(true)
    end

    it 'shoud have a category to select' do
      expect(page).to have_content('Electronics')
      expect(page).to have_content('Sport')
    end

    it 'shoud have sign up button' do
      expect(page).to have_button('Save')
    end

    it 'should create a transaction when credentials are correct' do
      fill_in 'Name', with: 'computer'
      fill_in 'Amount', with: '150'

      find(:css, "#groups_43[value='43']").set(true)
      find(:css, "#groups_44[value='44']").set(true)

      click_button 'Save'

      expect(page).to have_content('computer')
    end
  end
end
