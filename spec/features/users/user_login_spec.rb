require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do

  before :each do
    @user = create(:user, email: 'test@example.com', password: 'password123')
    visit root_path
    click_on 'Log in'
  end

  it 'fails with invalid credentials' do
    fill_in 'Email address', with: 'test@example.com'
    fill_in 'Password', with: 'wrongpassword'
    click_on 'Sign in'
    expect(page).to have_content('Invalid Email or password.')
  end

  it 'succeeds with valid credentials' do
    fill_in 'Email address', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    click_on 'Sign in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_current_path(dashboard_path)
  end

end
