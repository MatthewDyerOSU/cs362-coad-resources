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
    end


end
