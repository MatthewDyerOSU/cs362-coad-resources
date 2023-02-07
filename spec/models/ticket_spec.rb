require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:organization) { build_stubbed(:organization) }
  let (:region) { build_stubbed(:region) }
  let (:resource_category) { build_stubbed(:resource_category) }
  let (:ticket) { build_stubbed(:ticket) }

  it 'responds to name' do
    expect(ticket).to respond_to(:name)
  end

  it 'responds to phone' do
    expect(ticket).to respond_to(:phone)
  end

  it 'responds to description' do
    expect(ticket).to respond_to(:description)
  end

  it 'responds to closed' do
    expect(ticket).to respond_to(:closed)
  end

  it 'responds to closed_at' do
    expect(ticket).to respond_to(:closed_at)
  end

  it { should belong_to :region }

  it { should belong_to :resource_category }

  it { should belong_to(:organization).optional }

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :phone }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }
    it 'validates phone number' do
      ticket.phone = '1234567890'
      expect(Phony.plausible?(ticket.phone)).to be false
      expect(ticket).to_not be_valid
      ticket.phone = '+1 408-402-5812'
      expect(Phony.plausible?(ticket.phone)).to be true
      expect(ticket).to be_valid
    end
  end

  describe 'instance methods' do
    it 'is open when not closed' do
      ticket = build(:ticket, closed: false)
      expect(ticket.open?).to be true
      ticket = build(:ticket, closed: true)
      expect(ticket.open?).to be false
    end

    it 'is captured when organization is present' do
      ticket = build(:ticket, organization: nil)
      expect(ticket.captured?).to be false
      ticket = build(:ticket, organization: organization)
      expect(ticket.captured?).to be true
    end

    it 'has a string representation that follows the pattern "Ticket <id>"' do
      ticket = build(:ticket, id: 1)
      result = ticket.to_s
      expect(result).to eq('Ticket 1')
    end

  end

  describe 'scope methods' do
    it 'returns open tickets' do
      ticket = create(:ticket, closed: false)
      ticket2 = create(:ticket, closed: true)
      expect(Ticket.open).to include(ticket)
      expect(Ticket.open).to_not include(ticket2)
    end
    it 'returns closed tickets' do
      ticket = create(:ticket, closed: true)
      ticket2 = create(:ticket, closed: false)
      expect(Ticket.closed).to include(ticket)
      expect(Ticket.closed).to_not include(ticket2)
    end
    it 'returns all tickets for all organizations' do
      ticket = create(:ticket, organization: organization)
      ticket2 = create(:ticket, organization: organization)
      ticket3 = create(:ticket, organization: nil)
      expect(Ticket.all_organization).to include(ticket)
      expect(Ticket.all_organization).to include(ticket2)
      expect(Ticket.all_organization).to_not include(ticket3)
    end
    it 'returns all open tickets for a specific organization' do
      ticket = create(:ticket, organization: organization, closed: false)
      expect(Ticket.organization(organization.id)).to include(ticket)
      ticket2 = create(:ticket, organization: organization, closed: true)
      expect(Ticket.organization(organization.id)).to_not include(ticket2)
      ticket3 = create(:ticket, organization: nil, closed: false)
      expect(Ticket.organization(organization.id)).to_not include(ticket3)
    end
    it 'returns all closed tickets for a specific organization' do
      ticket = create(:ticket, organization: organization, closed: true)
      expect(Ticket.closed_organization(organization.id)).to include(ticket)
      ticket2 = create(:ticket, organization: organization, closed: false)
      expect(Ticket.closed_organization(organization.id)).to_not include(ticket2)
      ticket3 = create(:ticket, organization: nil, closed: true)
      expect(Ticket.closed_organization(organization.id)).to_not include(ticket3)
    end
    it 'returns all tickets for a specific region' do
      ticket = create(:ticket, region: region)
      ticket2 = create(:ticket, region: region)
      ticket3 = create(:ticket, region: create(:region))
      expect(Ticket.region(region.id)).to include(ticket)
      expect(Ticket.region(region.id)).to include(ticket2)
      expect(Ticket.region(region.id)).to_not include(ticket3)
    end
    it 'returns all tickets for a specific resource category' do
      ticket = create(:ticket, resource_category: resource_category)
      ticket2 = create(:ticket, resource_category: resource_category)
      ticket3 = create(:ticket, resource_category: create(:resource_category))
      expect(Ticket.resource_category(resource_category.id)).to include(ticket)
      expect(Ticket.resource_category(resource_category.id)).to include(ticket2)
      expect(Ticket.resource_category(resource_category.id)).to_not include(ticket3)
    end
  end

end
