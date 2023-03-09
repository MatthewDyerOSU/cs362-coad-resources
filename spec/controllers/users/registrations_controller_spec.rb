require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#check_captcha' do
    before { allow(controller).to receive(:verify_recaptcha).and_return(true) }
    let(:sign_up_params) { {email: 'text@example.com', password: 'password' } }
    let(:resource) { double(:resource) }
    let(:resource_class) { double(:resource_class, new: resource) }

    context 'when recaptcha is verified' do
      it 'does not render new view' do
        expect(controller).not_to receive(:render).with(:new)
        controller.send(:check_captcha)
      end
    end

    context 'when recaptcha is not verified' do
      before do
        allow(controller).to receive(:verify_recaptcha).and_return(false)
        allow(controller).to receive(:resource_class).and_return(resource_class)
        allow(controller).to receive(:sign_up_params).and_return(sign_up_params)
        allow(resource).to receive(:validate)
        allow(controller).to receive(:set_minimum_password_length)
        allow(controller).to receive(:respond_with_navigational)
      end

      it 'renders new view' do
        expect(controller).to receive(:render).with(:new)
        controller.send(:check_captcha)
      end
    end
  end
end
