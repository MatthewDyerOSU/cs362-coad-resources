require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do

  describe '#dashboard for' do

    it "returns 'admin_dashboard' for an admin" do
      user = build(:user, :admin)
      expect(helper.dashboard_for(user)).to eq('admin_dashboard')
    end

    it "returns 'organization_submitted_dashboard' for an organization that has submitted" do
      user = build(:user, :unapproved_org)
      expect(helper.dashboard_for(user)).to eq('organization_submitted_dashboard')
    end

    it "returns 'organization_approved_dashboard' for an organization that has been approved" do
      user = build(:user, :approved_org)
      expect(helper.dashboard_for(user)).to eq('organization_approved_dashboard')
    end

    it "returns 'create_application_dashboard' for users with no organization" do
      user = build(:user, organization: nil)
      expect(helper.dashboard_for(user)).to eq('create_application_dashboard')
    end

  end

end
