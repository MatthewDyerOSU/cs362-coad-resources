require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  describe '#after_sign_in_path_for' do
    it 'returns dashboard path' do
      expect(controller.after_sign_in_path_for(nil)).to eq(dashboard_path)
    end
  end

end
