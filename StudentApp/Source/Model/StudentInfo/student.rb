# frozen_string_literal: true

require_relative 'Validators/student_validator'
require_relative 'Contacts/contact_info'

class Student
	attr_accessor :id
	attr_reader :name, :middle_name, :surname, :git, :contact_info, :validator

	def initialize(kwargs)
		@id = kwargs[:id]
		@name = kwargs[:name]
		@surname = kwargs[:surname]
		@middle_name = kwargs[:middle_name]
		@git = Git.new(kwargs[:git]) if kwargs[:git]
		@contact_info = ContactInfo.new(kwargs[:contact_info]) if kwargs[:contact_info]

		@validator = StudentValidator.new self
		validator.validate
	end

	def self.from_string(string)
		hash = {}
		string.split(", ").each do |pair|
			key, value = pair.split(": ")
			hash[key.to_sym] = value
		end
		Student.new(
			id: hash[:id],
			name: hash[:name],
			surname: hash[:surname],
			middle_name: hash[:middle_name],
			git: hash[:git],
			contact_info: {phone: hash[:phone], email: hash[:email], telegram: hash[:telegram]}
		)
	end

	def to_s
		"#{id}, #{name}, #{surname}, #{middle_name}, #{git.to_s}, #{contact_info.to_s}"
	end

	def to_json
		{
			id: @id,
			name: @name,
			middle_name: @middle_name,
			surname: @surname,
			git: @git.to_s,
			contact_info: @contact_info.to_json
		}
	end

	def to_data
		{
			name: @name,
			middle_name: @middle_name,
			surname: @surname,
			git: @git.to_s,
			phone: @contact_info.phone.to_s,
			telegram: @contact_info.telegram.to_s,
			email: @contact_info.email.to_s
		}
	end

	def self.from_record(record)
		Student.new(
			id: record['id'],
			name: record['name'],
			middle_name: record['middle_name'],
			surname: record['surname'],
			git: record['git'],
			contact_info: {
				phone: record['phone'],
				telegram: record['telegram'],
				email: record['email']
			}
		)
	end

	def short_form
		[id, name_initials, git, contact_info.to_s]
	end

	def get_generic_info
		"#{name_initials}, Git: #{@git}, Contacts: #{contact_info.to_s}"
	end

	# Ex: Ivanov I.I.
	def name_initials
		"#{@surname} #{@name[0]}.#{@middle_name[0]}."
	end

	# MARK: Setters
	def name=(value)
		@name = value if value
	end

	def middle_name=(value)
		@middle_name = value if value
	end

	def surname=(value)
		@surname = value if value
	end

	def git=(value)
		# TODO: Can be done better
		old_git = @git
		@git = value
		@git = old_git unless validator.valid_git?
	end

	def contact_info=(value)
		# TODO: Can be done better
		old_contact_info = @contact_info
		@contact_info = value
		@contact_info = old_contact_info unless validator.valid_contact_info?
	end
end
