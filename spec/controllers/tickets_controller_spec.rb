require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
   
    let (:ticket) { create(:ticket) }
    let (:approved_organization) { create(:organization, status: :approved) }
    let (:user_without_org) { create(:user) }
    let (:admin_user) { create(:user, :admin) }
    let (:user_with_org) { create(:user, organization: approved_organization) }

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
        describe "User without organization" do
            it "redirects to dashboard" do
                sign_in user_without_org
                get :show, params: { id: ticket.id } 
                expect(response).to redirect_to(dashboard_path)
            end
        end

        describe "User as admin" do
            it "has http status of success" do
                sign_in admin_user
                get :show, params: { id: ticket.id }
                expect(response).to have_http_status(:success)
            end
        end

        describe "User with approved organization" do
            it "has http status of success" do
                sign_in user_with_org
                get :show, params: { id: ticket.id }
                expect(response).to have_http_status(:success)
            end
        end
    end

    describe "POST #capture" do
        describe "User without organization" do
            it "redirects to dashboard" do
                sign_in user_without_org
                post :capture, params: { id: ticket.id }
                expect(response).to redirect_to(dashboard_path)
            end
        end

        # this needs addressing
        describe "User with approved organization" do
            it "has http status of success" do
                sign_in user_with_org
                post :capture, params: { id: ticket.id }
                expect(response).to have_http_status(:success)
            end
        end
    end
end
