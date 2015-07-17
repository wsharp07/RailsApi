class RmasController < ApplicationController
  def new
    @rma = Rma.new
  end

  def index
    respond_to do |format|
      format.html
      format.json {

        render :json => Rma.joins('LEFT OUTER JOIN hardware_types ON rmas.hardware_type_id = hardware_types.id')
                            .select(
                                'rmas.id,
                                 rmas.rma_number,
                                 rmas.reference_number,
                                 rmas.serial_number,
                                 rmas.comments,
                                 rmas.created_at,
                                 rmas.updated_at,
                                 hardware_types.name as hardware_type_name') }
    end
  end

  def create
    @rma = Rma.new(rma_params)
    @rma.status = Rma.statuses[:active]
    if @rma.save
      flash[:success] = "'#{@rma.rma_number}' Created Successfully!"
      redirect_to root_path
    else
      render action: :new
    end
  end

  def update
  end

  def show
    @rma = Rma.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  def manage

  end

  private

  def rma_params
    params.require(:rma).permit(:serial_number, :reference_number, :tracking_number, :hardware_type, :comments).tap do |w|
      w[:hardware_type] = HardwareType.find(w[:hardware_type].to_i) if w[:hardware_type]
    end
  end
end
