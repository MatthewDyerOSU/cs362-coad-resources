require 'rails_helper'

RSpec.describe User, type: :model do

  let (:user) { User.new }

  it 'has an email' do
    expect(user).to respond_to(:email)
  end

  it 'has a role' do
    expect(user).to respond_to(:role)
  end

  it 'has an email' do
    expect(user).to respond_to(:email)
  end

  it 'has an encrypted_password' do
    expect(user).to respond_to(:encrypted_password)
  end

  it 'has a reset_password_token' do
    expect(user).to respond_to(:reset_password_token)
  end

  it 'has a reset_password_sent_at' do
    expect(user).to respond_to(:reset_password_sent_at)
  end

  it 'has a remember_created_at' do
    expect(user).to respond_to(:remember_created_at)
  end

  it 'has a confirmation_token' do
    expect(user).to respond_to(:confirmation_token)
  end

  it 'has a confirmed_at' do
    expect(user).to respond_to(:confirmed_at)
  end

  it 'has a confirmation_sent_at' do
    expect(user).to respond_to(:confirmation_sent_at)
  end

  it 'has an unconfirmed_email' do
    expect(user).to respond_to(:unconfirmed_email)
  end

  it { should belong_to(:organization).optional }

  it { should validate_presence_of(:email) }




end
