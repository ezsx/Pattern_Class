require_relative '../student'
require_relative 'validator'
require_relative '../Contacts/git'

class StudentValidator
	include Validator

	def validate
		valid_name? || raise('Name, surname, middle name are required')
		valid_contact_info? || raise('At least one contact is required')
	end

	def valid_git?
		@entity.git&.valid?
	end

	def valid_contact_info?
		@entity.contact_info&.valid?
	end

	private
	def valid_name?
		@entity.name && @entity.surname && @entity.middle_name
	end
end
