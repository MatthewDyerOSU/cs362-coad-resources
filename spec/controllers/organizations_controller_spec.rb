require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  describe "GET #new" do

    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "logged in" do
      it "redirects to dashboard for users with organizations" do
        sign_in create(:user)
        get :new
        expect(response).to redirect_to(dashboard_path)
      end

      it "returns http success for users without organizations" do
        sign_in create(:user, organization: nil)
        get :new
        expect(response).to have_http_status(:success)
      end
    end

  end

end
