class StatesController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @states = State.all
  end

end
