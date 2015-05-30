class HardwareTypesController < ApplicationController
  respond_to :json

  def new
    @hardware_type = HardwareType.new
    respond_with(@hardware_type)
  end

  def index
    render :json => HardwareType.order(:name)
  end

  def create
    @hardware_type = HardwareType.new(hardware_type_params)

    if @hardware_type.save
      respond_with @hardware_type, status: :created
    else
      respond_with @hardware_type.errors, status: :unprocessable_entity
    end
  end

  def edit
    @hardware_type = HardwareType.find(params[:id])
  end

  def update
    @hardware_type = HardwareType.find(params[:id])

    if @hardware_type.update_attributes(hardware_type_params)
      respond_with @hardware_type
    else
      respond_with @hardware_type.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @hardware_type = HardwareType.find(params[:id])
    @hardware_type.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def hardware_type_params
    params.require(:hardware_type).permit(:name)
  end

end
