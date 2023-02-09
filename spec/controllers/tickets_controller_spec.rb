require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
   
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

end
