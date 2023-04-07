require_relative 'contact'

class PhoneContact < Contact
	def valid?
		@value =~ /\A\+?\d{10}\z/
	end
end
