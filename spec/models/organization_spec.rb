require 'rails_helper'

RSpec.describe Organization, type: :model do

  it 'exists' do
    Organization.new
  end

  it 'has a name' do
    expect(Organization).to respond_to(:name)
  end

end
