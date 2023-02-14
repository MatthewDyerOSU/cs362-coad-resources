require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do

    let (:approved_organization) { create(:organization, status: :approved) }
    let (:user_without_org) { create(:user) }
    let (:admin_user) { create(:user, :admin) }
    let (:user_with_org) { create(:user, organization: approved_organization) }
    let (:resource_category) { create(:resource_category) }

    describe "User as an admin" do
        before(:each) do
            sign_in admin_user
        end

        describe "GET #index" do
            it "has http status of success" do
                get :index
                expect(response).to have_http_status(:success)
            end
        end

        describe "GET #show" do
            it "has http status of success" do
                get :show, params: { id: resource_category.id }
                expect(response).to have_http_status(:success)
            end
        end

        describe "GET #new" do
            it "has http status of success" do
                get :new
                expect(response).to have_http_status(:success)
            end
        end

        describe "POST #create" do
            it "redirects to resource_categories_path" do
                post :create, params: { resource_category: { name: "Sample Resource Category" } }
                expect(response).to redirect_to(resource_categories_path)
            end
        end

        describe "GET #edit" do
            it "has http status of success" do
                get :edit, params: { id: resource_category.id }
                expect(response).to have_http_status(:success)
            end
        end
    end

    describe "User with approved organization" do
        before(:each) do
            sign_in user_with_org
        end

        describe "GET #index" do
            it "redirects to dashboard" do
                get :index
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "GET #show" do
            it "redirects to dashboard" do
                get :show, params: { id: resource_category.id }
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "GET #new" do
            it "redirects to dashboard" do
                get :new
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "POST #create" do
            it "redirects to dashboard" do
                post :create, params: { resource_category: { name: "Sample Resource Category" } }
                expect(response).to redirect_to(dashboard_path)
            end
        end
    end

    describe "User without approved organization" do
        before(:each) do
            sign_in user_without_org
        end

        describe "GET #index" do
            it "redirects to dashboard" do
                get :index
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "GET #show" do
            it "redirects to dashboard" do
                get :show, params: { id: resource_category.id }
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "GET #new" do
            it "redirects to dashboard" do
                get :new
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "POST #create" do
            it "redirects to dashboard" do
                post :create, params: { resource_category: { name: "Sample Resource Category" } }
                expect(response).to redirect_to(dashboard_path)
            end
        end
    end
end
