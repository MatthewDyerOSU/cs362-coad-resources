require 'rails_helper'

RSpec.describe 'Creating a Ticket', type: :feature do
    it 'can create a ticket' do
        visit new_ticket_path
        fill_in 'ticket_name', with: 'Test Name'
        fill_in 'ticket_phone', with: '5555555555'
        select 'Bend', from: 'ticket_region_id'
        select 'General', from: 'ticket_resource_category_id'
        fill_in 'ticket_description', with: 'Test Description'
        click_on 'Send this help request'
        expect(current_path).to eq ticket_submitted_path
    end
end
