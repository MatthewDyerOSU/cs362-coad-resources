require 'rails_helper'

RSpec.describe TicketsHelper, type: :helper do

  describe 'formatting phone numbers' do
    it 'normalizes a phone number with a US country code' do
      phone_number = '555-555-5555'
      expect(helper.format_phone_number(phone_number)).to eq('+15555555555')
    end
  end

end
