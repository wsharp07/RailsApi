class NotInPastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add attribute, (options[:message] || "can't be blank")
    elsif value < DateTime.now.to_date
      record.errors.add attribute,
                        (options[:message] || "can't be in the past")
    end
  end
end