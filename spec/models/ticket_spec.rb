require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) { Ticket.new }

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
  end

end
