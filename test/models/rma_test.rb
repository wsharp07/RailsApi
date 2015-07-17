require 'test_helper'

class RmaTest < ActiveSupport::TestCase

  def setup
    @rma = Rma.new()
    @hardwareType = HardwareType.new()
    @hardwareType.name = "Feig"
    @rma.comments = "my test comment"
    @rma.hardware_type = @hardwareType
  end

  test 'should be valid' do
    assert @rma.valid?
  end

  test 'no rma number in database should generate default' do
    Rma.delete_all
    @rma.save()
    assert_equal("RMA-#{Time.now.year}-001", @rma.rma_number)
  end

  test 'existing rma should increment' do
    @rma.save()
    assert_equal("RMA-#{Time.now.year}-002", @rma.rma_number)
  end

end
