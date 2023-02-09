require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  let (:user_with_org) { create(:user) }
  let (:user_without_org) { create(:user, organization: nil) }

  describe "GET #new" do
    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "logged in as user with organization" do
      it "redirects to dashboard" do
        sign_in user_with_org
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
    end
    describe "logged in as user without organization" do
      it "returns http success" do
        sign_in user_without_org
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #index" do
    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH #update" do
    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH #approve" do
    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH #reject" do
    describe "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
