require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  let (:user_with_org) { create(:user) }
  let (:user_without_org) { create(:user, organization: nil) }

  describe "not logged in" do
    describe "GET #new" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET #index" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET #show" do
      it "redirects to login page" do
        get :show, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET #edit" do
      it "redirects to login page" do
        get :edit, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "PATCH #update" do
      it "redirects to login page" do
        patch :update, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "POST #create" do
      it "redirects to login page" do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "PATCH #approve" do
      it "redirects to login page" do
        patch :approve, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "PATCH #reject" do
      it "redirects to login page" do
        patch :reject, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "logged in as user with organization" do
    describe "GET #new" do
      it "redirects to dashboard" do
        sign_in user_with_org
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe "logged in as user without organization" do
    describe "GET #new" do
      it "returns http success" do
        sign_in user_without_org
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

end
