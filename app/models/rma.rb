class Rma < ActiveRecord::Base
  belongs_to :hardware_type

  # Callbacks
  before_create :before_create

  # Validations
  validates :serial_number, length: { minimum: 3 }, allow_blank: true
  validates :hardware_type, presence: true
  validates :comments, presence: true, length: { minimum: 5 }

  # Enums
  enum status: [ :inactive, :active, :archived ]

  private

    def before_create
      self.rma_number ||= generate_rma_number()
    end

    def generate_rma_number
      new_rma_array = Array.new
      new_rma_array.push("RMA")
      new_rma_array.push(Time.now.year)

      # Get the last RMA
      last_rma = Rma.select(:rma_number).order('id desc').first

      # If there is no RMA
      if(last_rma == nil)
        new_rma_array.push("001")
        return new_rma_array.join('-')
      end

      # Split the string
      current_rma_array = last_rma.rma_number.split('-')

      # Increment the RMA
      new_rma_array.push((current_rma_array[2].to_i + 1).to_s.rjust(3, '0'))
      return new_rma_array.join('-')

    end

end
