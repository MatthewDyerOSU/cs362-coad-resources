require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

    describe "GET #new" do
        
        describe "When creating new ticket" do
            it "Displays form for creating ticket" do
                get :new
                expect(response).to have_http_status(:success)
            end
        end





    end
end
