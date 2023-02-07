require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
  let!(:active_resource_category) { create(:resource_category, active: true) }
  let!(:inactive_resource_category) { create(:resource_category, active: false) }

  it { should have_many :tickets }
  it { should have_and_belong_to_many :organizations }

  it 'responds to active' do
    expect(active_resource_category).to respond_to(:active)
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  it 'if no name is specified, has a name of "Unspecified"' do
    expect(ResourceCategory.unspecified.name).to eq('Unspecified')
  end

  it 'has a string representation that is its name' do
    name = active_resource_category.name
    result = active_resource_category.to_s
    expect(result).to eq(name)
  end

  it 'is inactive when resource_category is not active' do
    expect(inactive_resource_category.inactive?).to be true
    expect(active_resource_category.inactive?).to be false
  end

  it 'is active when activate member function is called' do
    inactive_resource_category.activate
    expect(inactive_resource_category.active).to be true
  end

  it 'is not active when deactivate member function is called' do
    active_resource_category.deactivate
    expect(active_resource_category.active).to be false
  end

  describe 'scope methods' do
    it "returns only active ResourceCategories" do
      expect(ResourceCategory.active).to eq([active_resource_category])
    end

    it "returns only deactivated ResourceCategories" do
      expect(ResourceCategory.inactive).to eq([inactive_resource_category])
    end
  end

end
