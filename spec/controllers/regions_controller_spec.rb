require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  describe('User is not logged in') do
    it 'redirects to login page' do
      expect(get :index).to redirect_to(new_user_session_path)
      expect(get :show, params: { id: 1 }).to redirect_to(new_user_session_path)
      expect(get :new).to redirect_to(new_user_session_path)
      expect(post :create).to redirect_to(new_user_session_path)
      expect(get :edit, params: { id: 1 }).to redirect_to(new_user_session_path)
      expect(patch :update, params: { id: 1 }).to redirect_to(new_user_session_path)
      expect(delete :destroy, params: { id: 1 }).to redirect_to(new_user_session_path)
    end
  end

  describe('User is logged in as non-admin') do
    it 'redirects to dashboard' do
      sign_in(create(:user))
      expect(get :index).to redirect_to(dashboard_path)
      expect(get :show, params: { id: 1 }).to redirect_to(dashboard_path)
      expect(get :new).to redirect_to(dashboard_path)
      expect(post :create).to redirect_to(dashboard_path)
      expect(get :edit, params: { id: 1 }).to redirect_to(dashboard_path)
      expect(patch :update, params: { id: 1 }).to redirect_to(dashboard_path)
      expect(delete :destroy, params: { id: 1 }).to redirect_to(dashboard_path)
    end
  end

end
