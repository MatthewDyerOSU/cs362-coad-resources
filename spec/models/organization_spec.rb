require 'rails_helper'

RSpec.describe Organization, type: :model do

  let (:organization) { Organization.new}

  it 'has a name' do
    expect(organization).to respond_to(:name)
  end

  it 'has a phone' do
    expect(organization).to respond_to(:phone)
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

  describe Organization do
    it { should respond_to :agreement_eight }
    it { should respond_to :agreement_eight= }
  end


end
