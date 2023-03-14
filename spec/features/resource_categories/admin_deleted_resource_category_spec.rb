require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do

  it 'can be done by an admin' do
    admin = create(:user, :admin)
    resource_category = create(:resource_category, name: 'Test')

    log_in_as(admin)
    visit dashboard_path
    click_on 'Categories'
    click_on 'Test'
    click_on 'Delete'
    expect(page).to have_content('Category Test was deleted.')
  end

  it 'cannot be done by a non-admin' do
    user = create(:user)
    resource_category = create(:resource_category, name: 'Test')

    log_in_as(user)
    visit dashboard_path
    within('#navbar') do
      expect(page).not_to have_content('Categories')
    end
  end

end
