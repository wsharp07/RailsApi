class RequestTypesController < ApplicationController
  respond_to :json

  def new
    @request_type = RequestType.new
    respond_with(@request_type)
  end

  def index
    render :json => RequestType.order(:name)
  end

  def create
    @request_type = RequestType.new(request_type_params)

    if @request_type.save
      respond_with @request_type, status: :created
    else
      respond_with @request_type.errors, status: :unprocessable_entity
    end
  end

  def edit
    @request_type = RequestType.find(params[:id])
  end

  def update
    @request_type = RequestType.find(params[:id])

    if @request_type.update_attributes(request_type_params)
      respond_with @request_type
    else
      respond_with @request_type.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @request_type = RequestType.find(params[:id])
    @request_type.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
  def request_type_params
    params.require(:request_type).permit(:name)
  end
end
