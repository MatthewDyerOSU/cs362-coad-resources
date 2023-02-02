require 'rails_helper'

RSpec.describe User, type: :model do

  # let (:user) { User.new }
  let (:user) { create(:user) }

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

  it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }

  describe 'email format' do
    specify { expect(user).to allow_value('foo@example.com').for(:email) }
    specify { expect(user).to_not allow_value('foo').for(:email) }
  end

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_presence_of(:password).on(:create) }

  it { should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }

  it 'has a string representation that is its email' do
    email = 'eve@eavesdrop.org'
    user = create(:user, email: email)
    result = user.to_s
    expect(result).to eq(email)
  end

  it 'sets the unset default role to organization' do
    expect(user.role).to eq('organization')
  end

  it 'does not change the set role to default role' do
    user = User.new(role: 'admin')
    expect(user.role).to eq('admin')
  end

end
