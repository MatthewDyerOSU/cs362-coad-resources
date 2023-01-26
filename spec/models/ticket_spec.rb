require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) { Ticket.new(
    name: 'Test Name',
    phone: '+1 408-402-1234',
    description: 'Test Description',
    resource_category: ResourceCategory.new,
    region: Region.new
  ) }

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
      ticket = Ticket.new(closed: false)
      expect(ticket.open?).to be true
      ticket = Ticket.new(closed: true)
      expect(ticket.open?).to be false
    end

    it 'is captured when organization is present' do
      ticket = Ticket.new(organization: nil)
      expect(ticket.captured?).to be false
      ticket = Ticket.new(organization: Organization.new)
      expect(ticket.captured?).to be true
    end

    it 'has a string representation that follows the pattern "Ticket <id>"' do
      ticket = Ticket.new(id: 1)
      result = ticket.to_s
      expect(result).to eq('Ticket 1')
    end

  end

end
