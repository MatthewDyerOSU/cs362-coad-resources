require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  let (:user_with_org) { create(:user) }
  let (:user_without_org) { create(:user, organization: nil) }
  let (:admin_user) { create(:user, :admin) }

  describe "GET #new" do
    describe "not logged in" do
      it "redirects to login page" do
        expect(get :new).to redirect_to(new_user_session_path)
      end
    end
    describe "logged in as user with organization" do
      it "redirects to dashboard" do
        sign_in user_with_org
        expect(get :new).to redirect_to(dashboard_path)
      end
    end
    describe "logged in as user without organization" do
      it "is successful" do
        sign_in user_without_org
        expect(get :new).to be_successful
      end
    end
    describe "logged in as admin" do
      it "redirects to dashboard" do
        sign_in admin_user
        expect(get :new).to redirect_to(dashboard_path)
      end
    end
  end

  describe "GET #index" do
    describe "not logged in" do
      it "redirects to login page" do
        expect(get :index).to redirect_to(new_user_session_path)
      end
    end
    describe "logged in as user with organization" do
      it "is successful" do
        sign_in user_with_org
        expect(get :index).to be_successful
      end
    end
    describe "logged in as user without organization" do
      it "is successful" do
        sign_in user_without_org
        expect(get :index).to be_successful
      end
    end
    describe "logged in as admin" do
      it "is successful" do
        sign_in admin_user
        expect(get :index).to be_successful
      end
    end
  end

  describe "GET #show" do
    describe "not logged in" do
      it "redirects to login page" do
        expect(get :show, params: { id: 1 }).to redirect_to(new_user_session_path)
      end
    end
    describe "logged in as user with organization" do
      it "redirects to dashboard if not approved" do
        sign_in user_with_org
        user_with_org.organization.update(status: :rejected)
        expect(get :show, params: { id: 1 }).to redirect_to(dashboard_path)
      end
      it "is successful if approved" do
        sign_in user_with_org
        user_with_org.organization.update(status: :approved)
        expect(get :show, params: { id: 1 }).to be_successful
      end
    end
    describe "logged in as user without organization" do
      it "redirects to dashboard" do
        sign_in user_without_org
        expect(get :show, params: { id: 1 }).to redirect_to(dashboard_path)
      end
    end
    describe "logged in as admin" do
      it "is successful" do
        sign_in admin_user
        expect(get :show, params: { id: 1 }).to be_successful
      end
    end
  end

  describe "GET #edit" do
    describe "not logged in" do
      it "redirects to login page" do
        expect(get :edit, params: { id: 1 }).to redirect_to(new_user_session_path)
      end
    end
    describe "logged in as user with organization" do
      it "redirects to dashboard if not approved" do
        sign_in user_with_org
        user_with_org.organization.update(status: :rejected)
        expect(get :edit, params: { id: 1 }).to redirect_to(dashboard_path)
      end
      it "is successful if approved" do
        sign_in user_with_org
        user_with_org.organization.update(status: :approved)
        expect(get :edit, params: { id: 1 }).to be_successful
      end
    end
    describe "logged in as user without organization" do
      it "redirects to dashboard" do
        sign_in user_without_org
        expect(get :edit, params: { id: 1 }).to redirect_to(dashboard_path)
      end
    end
    describe "logged in as admin" do
      it "redirects to dashboard" do
        sign_in admin_user
        expect(get :edit, params: { id: 1 }).to redirect_to(dashboard_path)
      end
    end
  end

  describe "PATCH #update" do
    describe "not logged in" do
      it "redirects to login page" do
        expect(patch :update, params: { id: 1 }).to redirect_to(new_user_session_path)
      end
    end
    describe "logged in as user with organization" do
      it "redirects to dashboard if not approved" do
        sign_in user_with_org
        user_with_org.organization.update(status: :rejected)
        expect(patch :update, params: { id: 1, organization: {name: "foo"} }).to redirect_to(dashboard_path)
      end
      it "redirects to the organization page if approved" do
        sign_in user_with_org
        user_with_org.organization.update(status: :approved)
        expect(patch :update, params: { id: 1, organization: {name: "foo"} }).to redirect_to(organization_path(user_with_org.organization))
      end
      it "renders :edit if update fails" do
        sign_in user_with_org
        user_with_org.organization.update(status: :approved)
        # an empty name is invalid.
        expect(patch :update, params: { id: 1, organization: { name: "" } }).to render_template(:edit)
      end
    end
    describe "logged in as user without organization" do
      it "redirects to dashboard" do
        sign_in user_without_org
        expect(patch :update, params: { id: 1, organization: {name: "foo"} }).to redirect_to(dashboard_path)
      end
    end
    describe "logged in as admin" do
      it "redirects to dashboard" do
        sign_in admin_user
        expect(patch :update, params: { id: 1, organization: {name: "foo"} }).to redirect_to(dashboard_path)
      end
    end
  end

  describe "POST #create" do
    describe "not logged in" do
      it "redirects to login page" do
        expect(post :create).to redirect_to(new_user_session_path)
      end
    end
    describe "logged in as user with organization" do
      it "redirects to dashboard" do
        sign_in user_with_org
        expect(post :create).to redirect_to(dashboard_path)
      end
    end
    describe "logged in as user without organization" do
      it "redirects to submitted path when successful" do
        sign_in user_without_org
        _ = admin_user
        expect(post :create, params: { organization: build(:organization).attributes }).to redirect_to(organization_application_submitted_path)
      end
      it "it renders :new when create data is invalid" do
        sign_in user_without_org
        expect(post :create, params: { organization: {name: "foo"} }).to render_template(:new)
      end
    end
    describe "logged in as admin" do
      it "redirects to dashboard" do
        sign_in admin_user
        expect(post :create).to redirect_to(dashboard_path)
      end
    end
  end

  describe "POST #approve" do
    describe "not logged in" do
      it "redirects to login page" do
        expect(post :approve, params: { id: 1 }).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #reject" do
    describe "not logged in" do
      it "redirects to login page" do
        expect(post :reject, params: { id: 1 }).to redirect_to(new_user_session_path)
      end
    end
  end

end
