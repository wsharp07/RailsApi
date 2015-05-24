class HardwareTypesController < ApplicationController

  def new
    @hardware_type = Hardware_type.new
  end

  def index
    render :json => Hardware_type.all
  end

  def create

  end

  def edit

  end

  def update

  end

end
