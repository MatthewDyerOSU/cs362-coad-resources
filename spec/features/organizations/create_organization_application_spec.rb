require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do

  it 'is done by a user who is not part of an organization' do
    user = create(:user, organization: nil)
    log_in_as(user)

    d = double('UserMailer')
    allow(d).to receive(:deliver_now)
    allow(d).to receive(:new_organization_application).and_return(d)
    allow(UserMailer).to receive(:with).and_return(d)

    visit dashboard_path

    click_on 'Create Application'

    expect(page).to have_content 'Partner Organization Application'

    choose :organization_liability_insurance_true
    choose :organization_agreement_one_true
    choose :organization_agreement_two_true
    choose :organization_agreement_three_true
    choose :organization_agreement_four_true
    choose :organization_agreement_five_true
    choose :organization_agreement_six_true
    choose :organization_agreement_seven_true
    choose :organization_agreement_eight_true

    fill_in :organization_primary_name, with: 'Bond, James'
    fill_in 'Organization Name', with: 'MI6'
    fill_in :organization_title, with: 'Agent'
    fill_in :organization_phone, with: '555-555-5555'
    fill_in :organization_secondary_name, with: 'Moneypenny, Miss'
    fill_in :organization_secondary_phone, with: '555-555-5555'
    fill_in :organization_email, with: 'jb@example.com'
    fill_in 'Description', with: 'We are MI6, the British Secret Service. We are the best at what we do.'

    choose :organization_transportation_maybe

    click_on 'Apply'

    user.reload
    expect(user.organization).not_to be_nil
  end

  it 'cannot be done by a user who is already part of an organization' do
    user = create(:user)
    log_in_as(user)

    visit dashboard_path

    expect(page).not_to have_content 'Create Application'
  end

end
