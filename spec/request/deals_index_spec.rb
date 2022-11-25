require 'rails_helper'

RSpec.describe 'Deal', type: :feature do
  describe 'Index' do
    before(:each) do
      User.destroy_all
      Group.destroy_all
      Deal.destroy_all
      GroupDeal.destroy_all

      @user1 = User.new(name: 'ali', password: '1234567', email: 'ali@gmail.com')
      @user1.save

      @group1 = @user1.groups.new(id: 43, name: 'Electronics', icon: 'test icone')
      @group1.save

      @deal1 = @user1.deals.new(id: 76, name: 'Check', amount: 50)
      @deal1.save

      @d2 = @user1.deals.new(id: 75, name: 'Payment', amount: 40)
      @d2.save

      @gd1 = GroupDeal.new(deal_id: 76, group_id: 43)
      @gd2 = GroupDeal.new(deal_id: 75, group_id: 43)

      @gd1.save
      @gd2.save

      visit new_user_session_path
      fill_in 'Email', with: 'ali@gmail.com'
      fill_in 'Password', with: '1234567'
      click_button 'Log In'
      click_on 'Electronics'
    end

    it 'shoud show the transactions page' do
      expect(page).to have_content('TRANSACTIONS')
    end

    it 'should show the name of all my transactions' do
      expect(page).to have_content('Check')
      expect(page).to have_content('Payment')
    end

    it 'should show the total amount of each transaction' do
      expect(page).to have_content('$50.0')
      expect(page).to have_content('$40.0')
    end

    it 'should have a button to add transactions' do
      expect(page).to have_button('ADD TRANSACTION')
    end

    it 'should redirect to the add transaction page when clicking the add transaction button' do
      click_button 'ADD TRANSACTION'

      expect(page.current_path).to eq(new_group_deal_path(group_id: @group1.id))
    end

    it 'shoud be able to see the total amount of a category' do
      expect(page).to have_content('Total: $90.0')
    end
  end
end
