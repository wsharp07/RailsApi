class TimeOff < ActiveRecord::Base
  belongs_to :request_type

  # Validations
  validates :request_start_date, presence:true, not_in_past: true
  validates :request_end_date, presence: true
  validates :request_type, presence: true
  validates :comments, presence: true, length: { minimum: 5 }

  # Enums
  enum status: [ :closed, :open ]
end
