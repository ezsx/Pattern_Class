def validate_fields
  # may be need later
  # validate_surname
  # validate_first_name
  # validate_patronymic
  # validate_guide
  validate_contact
end



# just for now i think its extra parameters, if we need, we turn it on in future
#
#
# def validate_surname
#   raise ArgumentError, 'Surname is required' unless self.class.valid_surname?(surname)
# end
#
# def validate_first_name
#   raise ArgumentError, 'First name is required' unless self.class.valid_first_name?(first_name)
# end
#
# def validate_patronymic
#   raise ArgumentError, 'Patronymic is required' unless self.class.valid_patronymic?(patronymic)
# end
#
# def validate_guide
#   raise ArgumentError, 'A guide is required' unless (git || telegram || mail)
# end

#
# def self.valid_surname?(surname)
#   surname.is_a?(String) && surname.match(/\A[a-zA-Z]+\z/)
# end
#
# def self.valid_first_name?(first_name)
#   first_name.is_a?(String) && first_name.match(/\A[a-zA-Z]+\z/)
# end
#
# def self.valid_patronymic?(patronymic)
#   patronymic.is_a?(String) && patronymic.match(/\A[a-zA-Z]+\z/)
# end