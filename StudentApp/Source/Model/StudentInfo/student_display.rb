# frozen_string_literal: true

require_relative 'student'

class StudentDisplay
	attr_reader :id, :initials, :git, :contact

	def initialize(student)
		@id = student.id
		@initials = student.name_initials
		@git = student.git
		@contact = student.contact_info
	end

	def to_s
		"id: #{@id}, initials: #{@initials}, git: #{@git}, #{@contact.to_s}"
	end

	def single_contact
		return @contact.phone.to_s if @contact.phone
		return @contact.telegram.to_s if @contact.telegram
		@contact.email.to_s if @contact.email
	end

	def to_json
		{
			id: @id,
			initials: @initials,
			git: @git.to_s,
			contact: @contact.to_json
		}
	end

	def initials=
		# code here
	end

end
