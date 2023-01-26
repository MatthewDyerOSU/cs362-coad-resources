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

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  it 'has a name of "Unspecified"' do
    expect(ResourceCategory.unspecified.name).to eq('Unspecified')
  end

end
