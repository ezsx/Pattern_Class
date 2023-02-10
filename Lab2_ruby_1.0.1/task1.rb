class Student
  attr_accessor :id, :surname, :first_name, :patronymic, :phone, :telegram, :mail, :git

  def initialize(id, surname, first_name, patronymic, phone = nil, telegram = nil, mail = nil, git = nil)
    @id = id
    @surname = surname
    @first_name = first_name
    @patronymic = patronymic
    @phone = phone
    @telegram = telegram
    @mail = mail
    @git = git
  end
end
