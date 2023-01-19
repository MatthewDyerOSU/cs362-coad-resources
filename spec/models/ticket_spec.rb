require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) { Ticket.new }

  it 'responds to name' do
    expect(ticket).to respond_to(:name)
  end

end
