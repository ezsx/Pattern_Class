require_relative 'contact'

class TelegramContact < Contact
	def valid?
		@value =~ /^@[A-Za-z0-9_]{5,32}$/
	end
end
