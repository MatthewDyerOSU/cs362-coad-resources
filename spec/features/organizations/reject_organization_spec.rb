require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do
  it 'can be done from the dashboard' do
    user = create(:user, :admin)
    organization = create(:organization, status: :submitted)
    log_in_as(user)

    visit dashboard_path  # Navigate to the dashboard

    click_on 'Organizations'
    click_on 'Pending'
    first(:link, "Review").click
    fill_in 'organization_rejection_reason', :with => 'Reason for rejection'
    click_on 'Reject'
    expect(page).to have_content /Organization.*has been rejected\./
  end

  it 'cannot be done by a non-admin user' do
    organization = create(:organization, :approved)
    not_approved_organization = create(:organization)

    user = create(:user, organization: organization)

    log_in_as(user)

    visit dashboard_path

    visit organization_path(id: not_approved_organization.id)
    expect(page).not_to have_content 'Reject'
  end

end
