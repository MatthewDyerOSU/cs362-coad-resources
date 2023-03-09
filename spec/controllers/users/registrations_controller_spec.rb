require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#check_captcha' do
    context 'when recaptcha is verified' do
      it 'does not render new view' do
        expect(controller).not_to receive(:render).with(:new)
        controller.send(:check_captcha)
      end
    end
  end
end
