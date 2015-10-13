require 'test_helper'

class TimeOffTest < ActiveSupport::TestCase
  def setup
    @time_off = TimeOff.new()
    @requestType = RequestType.new()
    @requestType.name = "Vacation"
    @time_off.request_start_date = DateTime.now.to_date
    @time_off.request_end_date = 10.days.from_now.to_date
    @time_off.comments = "these are comments"
    @time_off.request_type = @requestType
  end

  test 'should_be_valid' do
    assert @time_off.valid?, @time_off.errors.messages
  end

  test 'no_start_date_should_be_invalid' do
    @time_off.request_start_date = nil
    assert @time_off.invalid?
  end

  test 'no_end_date_should_be_invalid' do
    @time_off.request_end_date = nil
    assert @time_off.invalid?
  end

  test 'past_start_date_should_be_invalid' do
    @time_off.request_start_date = 2.days.ago.to_date
    assert @time_off.invalid?
  end

end
