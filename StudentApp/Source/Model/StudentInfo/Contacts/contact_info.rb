require_relative 'phone_contact'
require_relative 'email_contact'
require_relative 'telegram_contact'

class ContactInfo
	attr_accessor :phone, :telegram, :email

	def initialize(kwargs)
		@phone = PhoneContact.new(kwargs[:phone]) if kwargs[:phone] && kwargs[:phone] != ""
		@telegram = TelegramContact.new(kwargs[:telegram]) if kwargs[:telegram] && kwargs[:telegram] != ""
		@email = EmailContact.new(kwargs[:email]) if kwargs[:email] && kwargs[:email] != ""
	end

	def to_s
		phone_info = "phone: #{phone.to_s}" if @phone
		email_info = "email: #{email.to_s}" if @email
		telegram_info = "telegram: #{telegram.to_s}" if @telegram
		[phone_info, email_info, telegram_info].compact.join(', ')
	end

	def to_json
		{
			phone: phone.to_s || "",
			email: email.to_s || "",
			telegram: telegram.to_s || ""
		}
	end

	def valid?
		phone.valid? || telegram.valid? || email.valid?
	end
end
