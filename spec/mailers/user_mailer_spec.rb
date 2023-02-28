require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe "development" do
    it 'returns false' do
      allow_any_instance_of(UserMailer).to receive(:params).and_return({to: ""})
      allow(Rails.env).to receive(:production?).and_return(false)
      allow(Rails.env).to receive(:test?).and_return(false)
      mailer = UserMailer.new
      expect(mailer.new_organization_application).to be_falsey
    end
  end

  describe "production" do
    it 'sends an email' do
      allow_any_instance_of(UserMailer).to receive(:mail)
      allow_any_instance_of(UserMailer).to receive(:params).and_return({to: ""})
      mailer = UserMailer.new
      mailer.new_organization_application
      expect(mailer).to have_received(:mail)
    end
  end

end
