require 'rails_helper'

RSpec.describe 'User registration', type: :feature do

  describe 'invalid password' do

    before :each do
      allow_any_instance_of(Users::RegistrationsController).to receive(:verify_recaptcha).and_return(true)
      visit root_path
      click_on 'Sign up'
      fill_in 'Email address', with: 'test@example.com'
    end

    it 'fails if passwords do not match' do
      fill_in 'Password', with: '1234567'
      fill_in 'Password confirmation', with: '12345678'
      within('#new_user') do
        click_on 'Sign up'
      end
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end

    it 'fails if passwords are less than 7 characters' do
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      within('#new_user') do
        click_on 'Sign up'
      end
      expect(page).to have_content('Password is too short (minimum is 7 characters)')
    end
  end

end
