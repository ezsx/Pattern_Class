require_relative 'contact'

class EmailContact < Contact
	def valid?
		@value =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	end
end