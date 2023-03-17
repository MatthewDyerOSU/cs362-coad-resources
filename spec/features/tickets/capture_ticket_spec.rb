require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do

  before :each do
    @org = create(:organization, status: :approved)
    create(
      :ticket,
      organization: nil,
      name: 'Test Ticket',
      region: create(:region),
      resource_category:
      create(:resource_category))
    visit dashboard_path
  end

  describe 'user with organization' do
    it 'can capture a ticket' do
      user = create(:user, organization: @org)
      log_in_as(user)
      click_on 'Test Ticket'
      find('[href="/tickets/1/capture"]').click
      click_on 'Test Ticket'
      expect(page).to_not have_selector('[href="/tickets/1/capture"]')
    end
  end

  describe 'admin with organization' do
    it 'can capture a ticket' do
      user = create(:user, :admin, organization: @org)
      log_in_as(user)
      click_on 'Test Ticket'
      find('[href="/tickets/1/capture"]').click
      click_on 'Test Ticket'
      expect(page).to_not have_selector('[href="/tickets/1/capture"]')
    end
  end

  describe 'user without organization' do
    it 'cannot capture a ticket' do
      user = create(:user, organization: nil)
      log_in_as(user)
      expect(page).to_not have_content('Test Ticket')
    end
  end

  describe 'admin without organization' do
    it 'cannot capture a ticket' do
      user = create(:user, :admin, organization: nil)
      log_in_as(user)
      click_on 'Test Ticket'
      expect(page).to_not have_selector('[href="/tickets/1/capture"]')
    end
  end

end
