require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
   
    let (:ticket) { create(:ticket) }
    let (:approved_organization) { create(:organization, status: :approved) }
    let (:user_without_org) { create(:user) }
    let (:admin_user) { create(:user, :admin) }
    let (:user_with_org) { create(:user, organization: approved_organization) }

    
    describe "User is an admin" do
        before(:each) do 
            sign_in admin_user
        end

        describe "GET #new" do
            it "has http status of success" do
                get :new
                expect(response).to have_http_status(:success)
            end
        end

        describe "POST #create" do
            it "has http status of success" do
                post :create, params: { ticket: { name: "Sample Ticket" } }
                expect(response).to have_http_status(:success)
            end
        end

        describe "GET #show" do
            it "has http status of success" do
                get :show, params: { id: ticket.id }
                expect(response).to have_http_status(:success)
            end
        end

        describe "POST #capture" do
            it "has http status of success" do
                post :capture, params: { id: ticket.id }
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "POST #release" do
            it "redirects to dashboard" do
                post :release, params: { id: ticket.id }
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "PATCH #close" do
            it "has http status of success" do
                post :close, params: { id: ticket.id }
                expect(response).to have_http_status(:success)
            end
        end
    end

    describe "Non admin user without organization" do
        before(:each) do
            sign_in user_without_org
        end

        describe "GET #new" do
            it "has http status of success" do
                get :new
                expect(response).to have_http_status(:success)
            end
        end

        describe "POST #create" do
            it "has http status of success" do
                post :create, params: { ticket: { name: "Sample Ticket" } }
                expect(response).to have_http_status(:success)
            end
        end

        describe "GET #show" do
            it "redirects to dashboard" do
                get :show, params: { id: ticket.id } 
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "POST #capture" do
            it "redirects to dashboard" do
                post :capture, params: { id: ticket.id }
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "POST #release" do
            it "redirects to dashboard" do
                post :release, params: { id: ticket.id }
                expect(response).to redirect_to(dashboard_path)
            end
        end
    end

    describe "Non admin user with approved organization" do
        before(:each) do
            sign_in user_with_org
        end

        describe "GET #new" do
            it "has http status of success" do
                get :new
                expect(response).to have_http_status(:success)
            end
        end

        describe "POST #create" do
            it "has http status of success" do
                post :create, params: { ticket: { name: "Sample Ticket" } }
                expect(response).to have_http_status(:success)
            end
        end

        describe "GET #show" do
            it "has http status of success" do
                get :show, params: { id: ticket.id }
                expect(response).to have_http_status(:success)
            end
        end

        describe "POST #capture" do
            it "has http status of success" do
                post :capture, params: { id: ticket.id }
                expect(response).to have_http_status(:success)
            end
        end

        describe "POST #release" do
            it "has http status of success" do
                post :release, params: { id: ticket.id }
                expect(response).to have_http_status(:success)
            end
        end
    end
end
