require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do
    let(:admin) { create(:user, :admin)}

    it 'successfully closes ticket' do
        log_in_as(admin)

        visit dashboard_path
        

    end

end
