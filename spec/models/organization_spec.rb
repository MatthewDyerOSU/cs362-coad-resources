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
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:primary_name) }
  it { should validate_presence_of(:secondary_name) }
  it { should validate_presence_of(:secondary_phone) }
  it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }

  it "has an invalid email" do
    email = "bademail.com"
    organization = Organization.new(email: email)
    expect(organization).to_not allow_value(email).for(:email)
  end

  it "has a valid email" do
    email = "valid@email.com"
    organization = Organization.new(email: email)
    expect(organization).to allow_value(email).for(:email)
  end

  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_length_of(:description).is_at_most(1020).on(:create) }

  it 'has a string representation that is its name' do
    name = 'test_org'
    organization = Organization.new(name: name)
    result = organization.to_s
    expect(result).to eq(name)
  end

  it 'sets the unset default status to submitted' do
    expect(organization.status).to eq('submitted')
  end

  it 'does not change the set status to default status' do
    organization = Organization.new(status: 'approved')
    expect(organization.status).to eq('approved')
  end








end
