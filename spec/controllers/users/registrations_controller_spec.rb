require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#check_captcha' do
    context 'when recaptcha is verified' do
      it 'does not render new view' do
        expect(controller).not_to receive(:render).with(:new)
        controller.send(:check_captcha)
      end
    end

    # context 'when recaptcha is not verified' do
    #   before do
    #     allow(controller).to receive(:verify_recaptcha).and_return(false)
    #   end
    #   it 'renders a new view' do
    #     expect(response).to render_template(:new)
    #   end
    # end
  end
end
