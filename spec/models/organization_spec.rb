require 'rails_helper'

RSpec.describe Organization, type: :model do

  it 'exists' do
    Organization.new
  end

  it 'has a name' do
    expect(Organization).to respond_to(:name)
  end

  describe Organization do
    it { should respond_to :agreement_one }
    it { should respond_to :agreement_one= }
  end

  describe Organization do
    it { should respond_to :agreement_two }
    it { should respond_to :agreement_two= }
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

end
