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
  end
end
