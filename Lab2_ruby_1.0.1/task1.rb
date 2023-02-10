class Student
  attr_accessor :id, :surname, :first_name, :patronymic, :phone, :telegram, :mail, :git

  def initialize(args = {})
    @id = args[:id]
    @surname = args[:surname]
    @first_name = args[:first_name]
    @patronymic = args[:patronymic]
    @phone = args[:phone]
    @telegram = args[:telegram]
    @mail = args[:mail]
    @git = args[:git]
    validate_fields
  end

  def validate_fields
    validate_surname
    validate_first_name
    validate_patronymic
    validate_phone_number
    validate_telegram
    validate_mail
    validate_git
  end

  def validate_surname
    raise ArgumentError, "Invalid surname" unless self.class.valid_surname?(@surname)
  end

  def validate_first_name
    raise ArgumentError, "Invalid first name" unless self.class.valid_first_name?(@first_name)
  end

  def validate_patronymic
    raise ArgumentError, "Invalid patronymic" unless self.class.valid_patronymic?(@patronymic)
  end

  def validate_phone_number
    raise ArgumentError, "Invalid phone number" unless self.class.valid_phone_number?(@phone)
  end

  def validate_telegram
    raise ArgumentError, "Invalid telegram username" unless self.class.valid_telegram?(@telegram)
  end

  def validate_mail
    raise ArgumentError, "Invalid email address" unless self.class.valid_mail?(@mail)
  end

  def validate_git
    raise ArgumentError, "Invalid git username" unless self.class.valid_git?(@git)
  end

  def self.valid_surname?(surname)
    surname.is_a?(String) && surname.match(/\A[a-zA-Z]+\z/)
  end

  def self.valid_first_name?(first_name)
    first_name.is_a?(String) && first_name.match(/\A[a-zA-Z]+\z/)
  end

  def self.valid_patronymic?(patronymic)
    patronymic.is_a?(String) && patronymic.match(/\A[a-zA-Z]+\z/)
  end

  def self.valid_phone_number?(phone)
    phone =~ /\A\d{3}-\d{3}-\d{4}\z/
  end

  def self.valid_telegram?(telegram)
    telegram.is_a?(String) && telegram.match(/\A@[a-zA-Z0-9]+\z/)
  end

  def self.valid_mail?(mail)
    mail.is_a?(String) && mail.match(/\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\z/)
  end

  def self.valid_git?(git)
    git.is_a?(String) && git.match(/\A[a-zA-Z0-9]+\z/)
  end
end
