require 'rails_helper'

RSpec.describe 'Creating a Ticket', type: :feature do
    it 'can create a ticket' do
        create(:region, name: 'Bend')
        create(:resource_category, name: 'General')
        visit new_ticket_path
        fill_in 'ticket_name', with: 'Test Name'
        fill_in 'ticket_phone', with: '5555555555'
        select 'Bend', from: 'ticket_region_id'
        select 'General', from: 'ticket_resource_category_id'
        fill_in 'ticket_description', with: 'Test Description'
        click_on 'Send this help request'
        expect(current_path).to eq ticket_submitted_path
    end

    it 'fails to create ticket when failing to make all selections' do
        visit new_ticket_path
        fill_in 'ticket_name', with: 'Test Name'
        fill_in 'ticket_phone', with: '5555555555'
        fill_in 'ticket_description', with: 'Test Description'
        click_on 'Send this help request'
        expect(page).to have_content('Region must exist')
        expect(page).to have_content('Resource category must exist')
        expect(current_path).to_not eq ticket_submitted_path
    end
end
