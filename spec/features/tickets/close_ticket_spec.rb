require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do
    let(:admin) { create(:user, :admin)}

    it 'admin successfully closes ticket' do
        region = create(:region, name: 'Bend')
        resource_category = create(:resource_category, name: 'Test Resource Category')
        ticket = create(:ticket, region: region, resource_category: resource_category)
        log_in_as(admin)
        visit dashboard_path
        find('a[href^="/tickets/"]').click
        click_on 'Close'
        find('a[href^="/tickets/"]').click
        expect(page).to have_css("dd.col-9", text: "Closed")
    end

    
    let(:org) { create(:organization, :approved)}
    let(:user) { create(:user, organization: org) }
    it 'non admin not able to close ticket' do
        region = create(:region, name: 'Bend')
        resource_category = create(:resource_category, name: 'Test Resource Category')
        ticket = create(:ticket, region: region, resource_category: resource_category)
        log_in_as(user)
        visit dashboard_path
        find('a[href^="/tickets/"]').click
        expect(page).to_not have_text('Close')
    end
end
