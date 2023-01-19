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

end
