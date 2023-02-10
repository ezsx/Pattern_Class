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
    validate_phone_number
  end

  def validate_phone_number
    raise ArgumentError, "Invalid phone number" unless self.class.valid_phone_number?(@phone)
  end

  def self.valid_phone_number?(phone)
    phone =~ /\A\d{3}-\d{3}-\d{4}\z/
  end
end

student = Student.new({id: 1, surname: 'Johnson', first_name: 'John', patronymic: 'Doe', phone: '555-555-5555'})
puts student.phone # 555-555-5555

student = Student.new({id: 2, surname: 'Smith', first_name: 'Jane', patronymic: 'Doe', phone: '555-555-555'})
# Raises ArgumentError: Invalid phone number
