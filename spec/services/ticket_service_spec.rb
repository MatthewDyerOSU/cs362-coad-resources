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
            TicketService.release_ticket(1, user)
        end
        it 'returns :ok when ticket successfully released' do
            expect(ticket).to receive(:organization_id=).with(nil)
            expect(TicketService.release_ticket(1, user)).to eq(:ok)
        end
    end

    describe '#capture_ticket' do
        let(:organization) { double('organization', id: 'some_org_id', approved?: true) }
        let(:user) { double('user', organization: organization, organization_id: 'some_org_id') }
        let(:ticket) { double('ticket', organization_id: nil, save: true) }
      
        before do
          allow(Ticket).to receive(:find).and_return(ticket)
          allow(ticket).to receive(:save).and_return(true)
        end
      
        it 'returns :ok when ticket successfully captured' do
          expect(ticket).to receive(:organization_id=).with('some_org_id')
          expect(TicketService.capture_ticket(1, user)).to eq(:ok)
        end
    end

    describe '#close_ticket' do
        
      
      
end
