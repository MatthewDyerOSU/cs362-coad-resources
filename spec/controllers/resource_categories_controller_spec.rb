require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do

    let (:approved_organization) { create(:organization, status: :approved) }
    let (:user_without_org) { create(:user) }
    let (:admin_user) { create(:user, :admin) }
    let (:user_with_org) { create(:user, organization: approved_organization) }
    let (:resource_category) { create(:resource_category) }


    describe('User is not logged in') do
        it 'redirects to login page' do
          expect(get :index).to redirect_to(new_user_session_path)
          expect(get :show, params: { id: resource_category.id }).to redirect_to(new_user_session_path)
          expect(get :new).to redirect_to(new_user_session_path)
          expect(post :create).to redirect_to(new_user_session_path)
          expect(get :edit, params: { id: resource_category.id }).to redirect_to(new_user_session_path)
          expect(patch :update, params: { id: resource_category.id }).to redirect_to(new_user_session_path)
          expect(patch :activate, params: { id: resource_category.id }).to redirect_to(new_user_session_path)
          expect(patch :deactivate, params: { id: resource_category.id }).to redirect_to(new_user_session_path)
          expect(delete :destroy, params: { id: resource_category.id }).to redirect_to(new_user_session_path)
        end
    end

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
            it "renders :new if if fails to save" do
                expect_any_instance_of(ResourceCategory).to receive(:save).and_return(false)
                post :create, params: { resource_category: { name: "Sample Resource Category" } }
                expect(response).to render_template(:new)
            end
        end

        describe "GET #edit" do
            it "has http status of success" do
                get :edit, params: { id: resource_category.id }
                expect(response).to have_http_status(:success)
            end
        end

        describe "PATCH #update" do
            it "redirects to @resource category" do
                patch :update, params: { id: resource_category.id, resource_category: { name: "New Category Name" } }
                expect(response).to redirect_to(resource_category_path(resource_category))
            end
            it "renders :edit if if fails to save" do
                expect_any_instance_of(ResourceCategory).to receive(:update).and_return(false)
                patch :update, params: { id: resource_category.id, resource_category: { name: "New Category Name" } }
                expect(response).to render_template(:edit)
            end
        end

        describe "PATCH #activate" do
            it "redirects to @resource_category" do
                patch :activate, params: { id: resource_category.id }
                expect(response).to redirect_to(resource_category_path(resource_category))
            end
            it "redirects to @resource_category with error if fails to activate" do
                expect_any_instance_of(ResourceCategory).to receive(:activate).and_return(false)
                patch :activate, params: { id: resource_category.id }
                expect(response).to redirect_to(resource_category_path(resource_category))
                expect(flash[:alert]).to be_present
            end
        end

        describe "PATCH #deactivate" do
            it "redirects to @resource_category" do
                patch :deactivate, params: { id: resource_category.id }
                expect(response).to redirect_to(resource_category_path(resource_category))
            end
            it "redirects to @resource_category with error if fails to deactivate" do
                expect_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(false)
                patch :deactivate, params: { id: resource_category.id }
                expect(response).to redirect_to(resource_category_path(resource_category))
                expect(flash[:alert]).to be_present
            end
        end

        describe "DELETE #destroy" do
            it "redirects to resource_categories_path" do
                delete :destroy, params: { id: resource_category.id }
                expect(response).to redirect_to(resource_categories_path)
            end
        end

    end

    describe "User is logged in with approved organization" do
        before(:each) do
            sign_in user_with_org
        end
        it 'redirects to dashboard' do
            sign_in(create(:user))
            expect(get :index).to redirect_to(dashboard_path)
            expect(get :show, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(get :new).to redirect_to(dashboard_path)
            expect(post :create).to redirect_to(dashboard_path)
            expect(get :edit, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(patch :update, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(patch :activate, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(patch :deactivate, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(delete :destroy, params: { id: resource_category.id }).to redirect_to(dashboard_path)
        end
    end

    describe "User is logged in without approved organization" do
        before(:each) do
            sign_in user_without_org
        end
        it 'redirects to dashboard' do
            sign_in(create(:user))
            expect(get :index).to redirect_to(dashboard_path)
            expect(get :show, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(get :new).to redirect_to(dashboard_path)
            expect(post :create).to redirect_to(dashboard_path)
            expect(get :edit, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(patch :update, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(patch :activate, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(patch :deactivate, params: { id: resource_category.id }).to redirect_to(dashboard_path)
            expect(delete :destroy, params: { id: resource_category.id }).to redirect_to(dashboard_path)
        end
    end

        # describe "GET #index" do
        #     it "redirects to dashboard" do
        #         get :index
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end

        # describe "GET #show" do
        #     it "redirects to dashboard" do
        #         get :show, params: { id: resource_category.id }
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end

        # describe "GET #new" do
        #     it "redirects to dashboard" do
        #         get :new
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end

        # describe "POST #create" do
        #     it "redirects to dashboard" do
        #         post :create, params: { resource_category: { name: "Sample Resource Category" } }
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end

        # describe "GET #edit" do
        #     it "redirects to dashboard" do
        #         get :edit, params: { id: resource_category.id }
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end

        # describe "PATCH #update" do
        #     it "redirects to @resource category" do
        #         patch :update, params: { id: resource_category.id, resource_category: { name: "New Category Name" } }
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end

        # describe "PATCH #activate" do
        #     it "redirects to dashboard" do
        #         patch :activate, params: { id: resource_category.id }
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end

        # describe "PATCH #deactivate" do
        #     it "redirects to dashboard" do
        #         patch :deactivate, params: { id: resource_category.id }
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end

        # describe "DELETE #destroy" do
        #     it "redirects to resource_categories_path" do
        #         delete :destroy, params: { id: resource_category.id }
        #         expect(response).to redirect_to(dashboard_path)
        #     end
        # end
end
