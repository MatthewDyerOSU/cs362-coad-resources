require 'rails_helper'

RSpec.describe TicketService do
    describe '#release_ticket' do
        let(:user) { double('user', organization_id: 'some_org_id') }
        let(:ticket) { double('ticket', organization_id: 'some_org_id', save: true) }
        before do
            allow(Ticket).to receive(:find).and_return(ticket)
            allow(ticket).to receive(:save).and_return(true)
        end
        it 'updates organization_id of ticket with nil' do
            expect(ticket).to receive(:organization_id=).with(nil)
            described_class.release_ticket(1, user)
        end
    end

end
