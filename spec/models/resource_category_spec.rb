require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:resource_category) { build(:resource_category) }

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

  it 'has a string representation that is its name' do
    name = 'test_resource_category'
    resource_category = ResourceCategory.new(name: name)
    result = resource_category.to_s
    expect(result).to eq(name)
  end

  it 'is inactive when resource_category is not active' do
    resource_category = ResourceCategory.new(active: false)
    expect(resource_category.inactive?).to be true
    resource_category = ResourceCategory.new(active: true)
    expect(resource_category.inactive?).to be false
  end

  it 'is active when activate member function is called' do
    resource_category = ResourceCategory.new
    resource_category.activate
    expect(resource_category.active).to be true
  end

  it 'is not active when deactivate member function is called' do
    resource_category = ResourceCategory.new
    resource_category.deactivate
    expect(resource_category.active).to be false
  end

  describe 'scope methods' do
    it "returns only active ResourceCategories" do
      active_resource_category = create(:resource_category, active: true)
      inactive_resource_category = create(:resource_category, active: false)

      expect(ResourceCategory.active).to eq([active_resource_category])
  end
end

end
