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

  it 'responds to region' do
    expect(ticket).to respond_to(:region)
  end

  it 'responds to resource_category' do
    expect(ticket).to respond_to(:resource_category)
  end

  it 'responds to organization' do
    expect(ticket).to respond_to(:organization)
  end

end
