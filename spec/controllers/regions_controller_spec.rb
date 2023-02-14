require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  let (:admin) { create(:user, :admin) }

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

  describe('User is logged in as admin') do

    before do
      sign_in admin
    end

    describe('GET #index') do
      it('is successful') do
        expect(get :index).to be_successful
      end
    end

    describe('GET #show') do
      it('is successful') do
        region = create(:region)
        expect(get :show, params: { id: region.id }).to be_successful
      end
    end

    describe('GET #new') do
      it('is successful') do
        expect(get :new).to be_successful
      end
    end

    describe('POST #create') do
      it('redirects to regions index for valid params') do
        expect(post :create, params: { region: build(:region).attributes }).to redirect_to(regions_path)
      end
      it('renders :new for invalid params') do
        expect(post :create, params: { region: { name: nil } }).to render_template(:new)
      end
    end

    describe('GET #edit') do
      it('is successful') do
        region = create(:region)
        expect(get :edit, params: { id: region.id }).to be_successful
      end
    end

    describe('PATCH #update') do
      it('redirects to region for valid params') do
        region = create(:region)
        expect(patch :update, params: { id: region.id, region: { name: 'New Name' } }).to redirect_to(region)
      end
      it('renders :edit for invalid params') do
        region = create(:region)
        expect(patch :update, params: { id: region.id, region: { name: nil } }).to render_template(:edit)
      end
    end

    describe('#destroy') do
      it('redirects to regions index') do
        region = create(:region)
        expect(delete :destroy, params: { id: region.id }).to redirect_to(regions_path)
      end
    end
  end

end
