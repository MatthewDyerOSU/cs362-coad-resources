require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do

  before :each do
    @org = create(:organization, status: :approved)
    create(
      :ticket,
      organization: @org,
      name: 'Test Ticket',
      region: create(:region),
      resource_category:
      create(:resource_category))
    visit dashboard_path
  end

  describe 'user with organization' do
    it 'can release a ticket' do
      user = create(:user, organization: @org)
      log_in_as(user)
      click_on 'Test Ticket'
      find('[href="/tickets/1/release"]').click
      click_on 'Test Ticket'
      expect(page).to_not have_selector('[href="/tickets/1/release"]')
    end
  end

  describe 'admin with organization' do
    it 'can release a ticket' do
      user = create(:user, :admin, organization: @org)
      log_in_as(user)
      click_on 'Test Ticket'
      find('[href="/tickets/1/release"]').click
      click_on 'Test Ticket'
      expect(page).to_not have_selector('[href="/tickets/1/release"]')
    end
  end

  describe 'user without organization' do
    it 'cannot release a ticket' do
      user = create(:user, organization: nil)
      log_in_as(user)
      expect(page).to_not have_content('Test Ticket')
    end
  end

  describe 'admin without organization' do
    it 'can release a ticket (but nothing happens)' do
      user = create(:user, :admin, organization: nil)
      log_in_as(user)
      click_on 'Test Ticket'
      find('[href="/tickets/1/release"]').click
      click_on 'Test Ticket'
      expect(page).to have_selector('[href="/tickets/1/release"]')
    end
  end

end
