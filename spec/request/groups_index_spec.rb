require 'rails_helper'

RSpec.describe 'Group', type: :feature do
  describe 'Index' do
    before(:each) do
      User.destroy_all
      Group.destroy_all

      @user1 = User.new(name: 'ali', password: '1234567', email: 'ali@gmail.com')
      @user1.save

      @group1 = @user1.groups.new(id: 54, name: 'Entertaiment', icon: 'test', total_amount: 123)

      @group2 = @user1.groups.new(name: 'Sport', icon: 'test', total_amount: 431)

      @group1.save
      @group2.save

      visit new_user_session_path
      fill_in 'Email', with: 'ali@gmail.com'
      fill_in 'Password', with: '1234567'
      click_button 'Log In'
    end

    it 'shoud show the categories page' do
      expect(page).to have_content('CATEGORIES')
    end

    it 'should show the name of all my categories' do
      expect(page).to have_content('Entertaiment')
      expect(page).to have_content('Sport')
    end

    it 'should show the total amount of each category' do
      expect(page).to have_content('$123.0')
      expect(page).to have_content('$431.0')
    end

    it 'should have a button to add categories' do
      expect(page).to have_button('ADD CATEGORY')
    end

    it 'should redirect to the add category page when clicking the add categories button' do
      click_button 'ADD CATEGORY'
      sleep 1

      expect(page.current_path).to eq(new_group_path)
    end

    it 'shoud redirect to the transactions page when clicking a category' do
      click_on 'Entertaiment'
      expect(page.current_path).to eq('/groups/54/deals')
    end
  end
end
