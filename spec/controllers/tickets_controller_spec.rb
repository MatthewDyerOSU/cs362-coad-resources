require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  let (:ticket) { create(:ticket) }
  let (:approved_organization) { create(:organization, status: :approved) }
  let (:user_without_org) { create(:user) }
  let (:admin_user) { create(:user, :admin) }
  let (:user_with_org) { create(:user, organization: approved_organization) }


  describe('User is not logged in') do
    it 'redirects to login page' do
      expect(get :show, params: { id: ticket.id }).to redirect_to(dashboard_path)
      expect(patch :capture, params: { id: ticket.id }).to redirect_to(dashboard_path)
      expect(patch :release, params: { id: ticket.id }).to redirect_to(dashboard_path)
      expect(patch :close, params: { id: ticket.id }).to redirect_to(dashboard_path)
      expect(delete :destroy, params: { id: ticket.id }).to redirect_to(dashboard_path)
    end
    it 'is successful' do
      expect(get :new).to be_successful
      expect(post :create, params: { ticket: {name: "Sample Ticket"}}).to be_successful
    end
  end

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
      it "has http status of success if it does not save" do
        post :create, params: { ticket: { name: "Sample Ticket" } }
        expect(response).to have_http_status(:success)
      end
      it "redirects to ticket_submitted_path if it saves" do
        expect_any_instance_of(Ticket).to receive(:save).and_return(true)
        post :create, params: { ticket: { name: "Sample Ticket" } }
        expect(response).to redirect_to(ticket_submitted_path)
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
      it 'redirects to dashboard#tickets:open if close is ok' do
        allow(TicketService).to receive(:close_ticket).and_return(:ok)
        post :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:open')
      end
    end

    describe "DELETE #destroy" do
      it "redirects to dashboard#tickets" do
        delete :destroy, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets')
      end
    end

    describe "POST #release" do
      it "redirects to dashboard#tickets:captured for valid ticket release and approved organization" do
        admin_user.organization = approved_organization
        admin_user.save
        allow(TicketService).to receive(:release_ticket).and_return(:ok)
        post :release, params: { id: 1 }
        expect(response).to redirect_to(dashboard_path << '#tickets:captured')
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
      it "has http status of success if it does not save" do
        post :create, params: { ticket: { name: "Sample Ticket" } }
        expect(response).to have_http_status(:success)
      end
      it "redirects to ticket_submitted_path if it saves" do
        expect_any_instance_of(Ticket).to receive(:save).and_return(true)
        post :create, params: { ticket: { name: "Sample Ticket" } }
        expect(response).to redirect_to(ticket_submitted_path)
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

    describe "PATCH #close" do
      it "redirects to dashboard" do
        post :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to dashboard#tickets" do
        delete :destroy, params: { id: ticket.id }
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
      it "has http status of success if it does not save" do
        post :create, params: { ticket: { name: "Sample Ticket" } }
        expect(response).to have_http_status(:success)
      end
      it "redirects to ticket_submitted_path if it saves" do
        expect_any_instance_of(Ticket).to receive(:save).and_return(true)
        post :create, params: { ticket: { name: "Sample Ticket" } }
        expect(response).to redirect_to(ticket_submitted_path)
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
      it "redirects to dashboard#tickets:open if capture ticket == ok" do
        allow(TicketService).to receive(:capture_ticket).and_return(:ok)
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:open')
      end
    end

    describe "POST #release" do
      it "has http status of success" do
        post :release, params: { id: ticket.id }
        expect(response).to have_http_status(:success)
      end
      it 'redirects to dashboard#tickets:organization if release ticket == ok' do
        allow(TicketService).to receive(:release_ticket).and_return(:ok)
        post :release, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:organization')
      end
    end

    describe "PATCH #close" do
      it "has http status of success" do
        post :close, params: { id: ticket.id }
        expect(response).to have_http_status(:success)
      end
      it 'redirects to dashboard#tickets:organization if close ticket == ok' do
        allow(TicketService).to receive(:close_ticket).and_return(:ok)
        post :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:organization')
      end
    end

    describe "DELETE #destroy" do
      it "redirects to dashboard#tickets" do
        delete :destroy, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
