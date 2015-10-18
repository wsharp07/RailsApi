class NotInPastValidator < ActiveModel::EachValidator
  uses_messages :not_in_past

  def validate_each(record, attribute, value)
    if value < DateTime.now.to_date
      record.errors.add attribute,
                        (options[:not_in_past] || "can't be in the past")
    end
  end
end