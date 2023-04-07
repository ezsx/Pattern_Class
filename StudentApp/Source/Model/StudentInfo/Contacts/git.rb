# frozen_string_literal: true

require_relative 'contact'
class Git < Contact
	def valid?
		@value =~ /\Ahttps:\/\/github\.com\/\w+\z/
	end

	def to_json
		@value || ""
	end
end
