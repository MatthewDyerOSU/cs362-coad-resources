require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
   
    let (:ticket) { create(:ticket) }
    let (:user) { create(:user) }

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
            sign_in user
            get :show, params: { id: ticket.id } 
            # expect(response).to have_http_status(:success)
            # expect(response).to redirect_to(ticket_path)
            expect(response).to redirect_to(dashboard_path)
        end
    end

end
