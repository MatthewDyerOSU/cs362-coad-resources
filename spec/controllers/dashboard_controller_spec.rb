require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #index" do

    describe "when not logged in" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "when logged in" do
      it "returns http success for regular user" do
        sign_in create(:user)
        get :index
        expect(response).to have_http_status(:success)
      end
      it "returns http success for admin user" do
        sign_in create(:user, :admin)
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
