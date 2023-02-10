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
  end
end
