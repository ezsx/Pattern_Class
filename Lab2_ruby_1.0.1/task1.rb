class Student
  attr_accessor :id, :surname, :first_name, :patronymic, :phone, :telegram, :mail, :git

  def initialize(options = {})
    @id = options[:id]
    @surname = options[:surname]
    @first_name = options[:first_name]
    @patronymic = options[:patronymic]
    @phone = options[:phone]
    @telegram = options[:telegram]
    @mail = options[:mail]
    @git = options[:git]
    validate_fields
  end

  def validate_fields
    validate_surname
    validate_first_name
    validate_patronymic
    validate_guide
    validate_contact
  end

  def validate_surname
    raise ArgumentError, 'Surname is required' unless self.class.valid_surname?(surname)
  end

  def validate_first_name
    raise ArgumentError, 'First name is required' unless self.class.valid_first_name?(first_name)
  end

  def validate_patronymic
    raise ArgumentError, 'Patronymic is required' unless self.class.valid_patronymic?(patronymic)
  end

  def validate_guide
    raise ArgumentError, 'A guide is required' unless (git || telegram || mail)
  end

  def validate_contact
    raise ArgumentError, 'A contact for communication is required' unless (phone || telegram || mail)
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

  def self.valid_phone?(phone)
    phone.is_a?(String) && phone.match(/\A[0-9]+\z/)
  end

  def self.valid_telegram?(telegram)
    telegram.is_a?(String) && telegram.match(/\A[a-zA-Z0-9]+\z/)
  end

  def self.valid_mail?(mail)
    mail.is_a?(String) && mail.match(/\A[a-zA-Z0--9]+@[a-z]+.[a-z]+\z/)
  end

  def self.valid_git?(git)
    git.is_a?(String) && git.match(/\Ahttps?://github.com/[a-zA-Z0-9]+/[a-zA-Z0-9]+\z/)
  end
end