require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do

  it 'can be done by an admin' do
    admin = create(:user, :admin)
    region = create(:region, name: 'Test')

    log_in_as(admin)
    visit dashboard_path
    click_on 'Regions'
    click_on 'Test'
    click_on 'Delete'
    expect(page).to have_content('Region Test was deleted.')
    within('.list-group') do
      expect(page).not_to have_content('Test')
    end
  end

  it 'cannot be done by a non-admin' do
    user = create(:user)
    region = create(:region, name: 'Test')

    log_in_as(user)
    visit dashboard_path
    within('#navbar') do
      expect(page).not_to have_content('Regions')
    end
  end
end
