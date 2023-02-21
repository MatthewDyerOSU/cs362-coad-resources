require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
    describe "#full_title" do
        it "returns the base title when given an empty string" do
          expect(helper.full_title).to eq("Disaster Resource Network")
        end
    
        
      end
    
end
