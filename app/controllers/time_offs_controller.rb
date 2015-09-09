class TimeOffsController < ApplicationController
  before_action :set_time_off, only: [:show, :edit, :update, :destroy]

  # GET /time_offs
  # GET /time_offs.json
  def index
    respond_to do |format|
      format.html
      format.json {

        render :json => TimeOff.joins('LEFT OUTER JOIN request_types ON time_offs.request_type_id = request_types.id')
                            .select(
                                'time_offs.id,
                                 time_offs.comments,
                                 request_types.name as request_type_name') }
    end
  end

  # GET /time_offs/1
  # GET /time_offs/1.json
  def show
  end

  # GET /time_offs/new
  def new
    @time_off = TimeOff.new
  end

  def manage

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_off
      @time_off = TimeOff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_off_params
      params[:time_off]
    end
end
