require 'rails_helper'

RSpec.describe Region, type: :model do

  let (:region) { Region.new }

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
    expect(result).to eq(name)
  end

  it { should have_many :tickets }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }

  it { should validate_uniqueness_of(:name).case_insensitive }

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
    expect(result).to eq(name)
  end

  describe 'unspecified region' do
    it 'has a name of "Unspecified"' do
      expect(Region.unspecified.name).to eq('Unspecified')
    end
  end

end
