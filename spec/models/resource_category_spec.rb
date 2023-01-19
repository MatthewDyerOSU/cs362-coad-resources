require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:resource_category) { ResourceCategory.new }

  it 'responds to name' do
    expect(resource_category).to respond_to(:name)
  end

  it 'responds to active' do
    expect(resource_category).to respond_to(:active)
  end

  it { should have_many :tickets }

  it { should have_and_belong_to_many :organizations }

end
