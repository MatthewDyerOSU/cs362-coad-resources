require 'rails_helper'

RSpec.describe Region, type: :model do

  let (:region) { build_stubbed(:region) }

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = build(:region, name: name)
    result = region.to_s
    expect(result).to eq(name)
  end

  it { should have_many :tickets }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }

  it { should validate_uniqueness_of(:name).case_insensitive }

  describe 'unspecified region' do

    it 'has a name of "Unspecified"' do
      expect(Region.unspecified.name).to eq('Unspecified')
    end

    it 'creates a new region if one does not exist' do
      Region.destroy_all
      expect(Region.count).to eq(0)
      region = Region.unspecified
      expect(region).to be_a(Region)
      expect(Region.count).to eq(1)
      expect(region).to eq(Region.first)
    end

    it 'finds an existing region if one exists' do
      test_region = create(:region, name: 'Unspecified')
      region = Region.unspecified
      expect(region).to eq test_region
    end

  end

end
