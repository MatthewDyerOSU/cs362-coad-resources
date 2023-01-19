require 'rails_helper'

RSpec.describe Organization, type: :model do

  let (:organization) { Organization.new}

  it 'has a name' do
    expect(organization).to respond_to(:name)
  end

  it 'has a phone' do
    expect(organization).to respond_to(:phone)
  end

  it 'has an email' do
    expect(organization).to respond_to(:email)
  end

  it 'has a description' do
    expect(organization).to respond_to(:description)
  end

  it 'has a rejection_reason' do
    expect(organization).to respond_to(:rejection_reason)
  end

  it 'has liability_insurance' do
    expect(organization).to respond_to(:liability_insurance)
  end

  it 'has a primary_name' do
    expect(organization).to respond_to(:primary_name)
  end

  it 'has a secondary_name' do
    expect(organization).to respond_to(:secondary_name)
  end

  it 'has a secondary_phone' do
    expect(organization).to respond_to(:secondary_phone)
  end

  it 'has a title' do
    expect(organization).to respond_to(:title)
  end

  it 'has transportation' do
    expect(organization).to respond_to(:transportation)
  end

  it 'has an agreement_one' do
    expect(organization).to respond_to(:agreement_one)
  end

  it 'has an agreement_two' do
    expect(organization).to respond_to(:agreement_two)
  end

  it 'has an agreement_three' do
    expect(organization).to respond_to(:agreement_three)
  end

  it 'has an agreement_four' do
    expect(organization).to respond_to(:agreement_four)
  end

  it 'has an agreement_five' do
    expect(organization).to respond_to(:agreement_five)
  end

  it 'has an agreement_six' do
    expect(organization).to respond_to(:agreement_six)
  end

  it 'has an agreement_seven' do
    expect(organization).to respond_to(:agreement_seven)
  end

  it 'has an agreement_eight' do
    expect(organization).to respond_to(:agreement_eight)
  end

  it { should have_many :users }

  it { should have_many :tickets }

  it { should have_and_belong_to_many :resource_categories }

  it { should validate_presence_of(:name) }







end
