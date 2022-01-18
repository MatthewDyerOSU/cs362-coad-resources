require 'rails_helper'

RSpec.describe State, type: :model do

  it "exists" do
    State.new
  end

  it "has a text representation that is its name" do
    name = 'Fake State'
    state = State.new(name: name)
    expect(state.to_s).to eq(name)
  end

end
