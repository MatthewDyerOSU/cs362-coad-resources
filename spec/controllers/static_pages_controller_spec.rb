require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #index" do
    it "is successful" do
      expect(get :index).to be_successful
    end
  end

  describe "GET #ticket_submitted" do
    it "is successful" do
      expect(get :ticket_submitted).to be_successful
    end
  end

  describe "GET #organization_expectations" do
    it "is successful" do
      expect(get :organization_expectations).to be_successful
    end
  end

end
