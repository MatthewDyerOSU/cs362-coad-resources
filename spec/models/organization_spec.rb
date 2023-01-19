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

  describe Organization do
    it { should respond_to :agreement_three }
    it { should respond_to :agreement_three= }
  end

  describe Organization do
    it { should respond_to :agreement_four }
    it { should respond_to :agreement_four= }
  end

  describe Organization do
    it { should respond_to :agreement_five }
    it { should respond_to :agreement_five= }
  end

  describe Organization do
    it { should respond_to :agreement_six }
    it { should respond_to :agreement_six= }
  end

  describe Organization do
    it { should respond_to :agreement_seven }
    it { should respond_to :agreement_seven= }
  end

  describe Organization do
    it { should respond_to :agreement_eight }
    it { should respond_to :agreement_eight= }
  end


end
