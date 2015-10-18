class TimeOffsController < ApplicationController
  before_action :set_time_off, only: [:show, :edit, :update, :destroy]

  # GET /time_offs
  # GET /time_offs.json
  def index
    respond_to do |format|
      format.html
      format.json {

        render :json => TimeOff.joins('LEFT OUTER JOIN request_types ON time_offs.request_type_id = request_types.id')
                            .joins('INNER JOIN users ON time_offs.user_id = users.id')
                            .select(
                                'time_offs.id,
                                 time_offs.request_start_date,
                                 time_offs.request_end_date,
                                 time_offs.status,
                                 time_offs.comments,
                                 users.name as users_name,
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

  def create
    @time_off = TimeOff.new(time_off_params)
    @time_off.status = TimeOff.statuses[:open]
    if @time_off.save
      flash[:success] = "Time Off Request #'#{@time_off.id}' Created Successfully!"
      redirect_to root_path
    else
      render action: :new
    end
  end

  def manage

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_off
      @time_off = TimeOff.find(params[:id])
    end

    def time_off_params
      params.require(:time_off).permit(:request_start_date, :request_end_date, :request_type, :user_id, :comments).tap do |w|
        w[:request_type] = RequestType.find(w[:request_type].to_i) if w[:request_type]
        w[:request_start_date] = Date.strptime(w[:request_start_date], "%m/%d/%Y")
        w[:request_end_date] = Date.strptime(w[:request_end_date], "%m/%d/%Y")
      end
    end
end
