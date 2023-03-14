require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do

  it 'can be done by an admin' do
    admin = create(:user, :admin)
    ticket = create(
      :ticket,
      name: 'Test',
      region: create(:region),
      resource_category: create(:resource_category)
    )

    log_in_as(admin)
    visit dashboard_path
    click_on 'Test'
    click_on 'Delete'
    expect(page).to have_content(/Ticket \d+ was deleted\./)
    within('.list-group') do
      expect(page).not_to have_content('Test')
    end
  end

  it 'cannot be done by a non-admin' do
    user = create(:user, :approved_org)
    ticket = create(
      :ticket,
      name: 'Test',
      region: create(:region),
      resource_category: create(:resource_category)
    )

    log_in_as(user)
    visit dashboard_path
    click_on 'Test'
    expect(page).not_to have_content('Delete')
  end

end
