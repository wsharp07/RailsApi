class RmasController < ApplicationController
  def new
    @rma = Rma.new
  end

  def index
    respond_to do |format|
      format.html
      format.json { render :json => Rma.order(:rma_number)}
    end
  end

  def create
    @rma = Rma.new(rma_params)
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
    params.require(:rma).permit(:serial_number, :reference_number, :comments)
  end
end
